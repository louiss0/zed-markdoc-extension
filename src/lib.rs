use std::env;
use std::path::PathBuf;

use zed::serde_json::{self, json, Value};
use zed_extension_api as zed;

const EXTENSION_ID: &str = "markdoc";
const PACKAGE: &str = "@markdoc/language-server";
const VERSION: &str = "latest";
const RELATIVE_ENTRY: &str = "node_modules/@markdoc/language-server/dist/wrapper.js";
const NODE_MODULES_DIR: &str = "node_modules";

struct MarkdocExtension;

impl zed::Extension for MarkdocExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<zed::Command> {
        let mut env_vars = worktree.shell_env();
        let (install_dir, script_path) = match find_installation(&env_vars) {
            Some(paths) => paths,
            None => {
                install_managed_package(language_server_id)?;
                match find_installation(&env_vars) {
                    Some(paths) => paths,
                    None => {
                        let checked_paths = candidate_install_dirs(&env_vars)
                            .into_iter()
                            .map(|path| path.join(RELATIVE_ENTRY).display().to_string())
                            .collect::<Vec<_>>()
                            .join(", ");
                        let error =
                            format!("markdoc-ls entrypoint missing; checked {}", checked_paths);
                        zed::set_language_server_installation_status(
                            language_server_id,
                            &zed::LanguageServerInstallationStatus::Failed(error.clone()),
                        );
                        return Err(error);
                    }
                }
            }
        };

        let node_modules_dir = install_dir.join(NODE_MODULES_DIR);
        let node_path_value = node_modules_dir.to_string_lossy().into_owned();
        let path_separator = match zed::current_platform().0 {
            zed::Os::Windows => ";",
            _ => ":",
        };
        match env_vars.iter_mut().find(|(key, _)| key == "NODE_PATH") {
            Some((_, value)) => {
                if !value.is_empty() {
                    value.push_str(path_separator);
                }
                value.push_str(&node_path_value);
            }
            None => env_vars.push(("NODE_PATH".into(), node_path_value)),
        }

        let node_binary = match zed::node_binary_path() {
            Ok(path) => path,
            Err(error) => {
                zed::set_language_server_installation_status(
                    language_server_id,
                    &zed::LanguageServerInstallationStatus::Failed(error.clone()),
                );
                return Err(error);
            }
        };

        Ok(zed::Command {
            command: node_binary,
            args: vec![script_path.to_string_lossy().into_owned(), "--stdio".into()],
            env: env_vars,
        })
    }

    fn language_server_initialization_options(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<Option<Value>> {
        let root = worktree.root_path();
        let config_path = "markdoc.config.json";

        if let Ok(contents) = worktree.read_text_file(config_path) {
            if let Ok(Value::Array(entries)) = serde_json::from_str::<Value>(&contents) {
                if let Some(Value::Object(first)) = entries.first().cloned() {
                    let path = first
                        .get("path")
                        .and_then(|value| value.as_str())
                        .unwrap_or(".")
                        .to_string();
                    let mut config = first;
                    config.insert("root".into(), Value::String(root.clone()));
                    config.insert("path".into(), Value::String(path.clone()));

                    return Ok(Some(json!({
                        "root": root,
                        "path": path,
                        "config": config,
                    })));
                }
            }
        }

        Ok(Some(json!({
            "root": root,
            "path": ".",
            "config": {
                "root": root,
                "path": ".",
            },
        })))
    }
}

zed::register_extension!(MarkdocExtension);

fn install_managed_package(language_server_id: &zed::LanguageServerId) -> zed::Result<()> {
    zed::set_language_server_installation_status(
        language_server_id,
        &zed::LanguageServerInstallationStatus::CheckingForUpdate,
    );

    let needs_install = match zed::npm_package_installed_version(PACKAGE) {
        Ok(Some(_)) => false,
        Ok(None) => true,
        Err(error) => {
            zed::set_language_server_installation_status(
                language_server_id,
                &zed::LanguageServerInstallationStatus::Failed(error.clone()),
            );
            return Err(error);
        }
    };

    if needs_install {
        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::Downloading,
        );

        if let Err(error) = zed::npm_install_package(PACKAGE, VERSION) {
            zed::set_language_server_installation_status(
                language_server_id,
                &zed::LanguageServerInstallationStatus::Failed(error.clone()),
            );
            return Err(error);
        }
    }

    zed::set_language_server_installation_status(
        language_server_id,
        &zed::LanguageServerInstallationStatus::None,
    );

    Ok(())
}

fn find_installation(env_vars: &zed::EnvVars) -> Option<(PathBuf, PathBuf)> {
    candidate_install_dirs(env_vars)
        .into_iter()
        .find_map(|install_dir| {
            let script_path = install_dir.join(RELATIVE_ENTRY);
            script_path.exists().then_some((install_dir, script_path))
        })
}

fn candidate_install_dirs(env_vars: &zed::EnvVars) -> Vec<PathBuf> {
    let mut candidates = Vec::new();

    push_unique_path(
        &mut candidates,
        env_value(env_vars, "ZED_EXTENSION_WORK_DIR").map(PathBuf::from),
    );
    push_unique_path(
        &mut candidates,
        env_value(env_vars, "PWD").map(PathBuf::from),
    );
    push_unique_path(&mut candidates, env::current_dir().ok());

    let current_os = zed::current_platform().0;

    if let Some(local_app_data) = env_value(env_vars, "LOCALAPPDATA") {
        push_unique_path(
            &mut candidates,
            Some(
                PathBuf::from(local_app_data)
                    .join("Zed")
                    .join("extensions")
                    .join("work")
                    .join(EXTENSION_ID),
            ),
        );
    }

    if let Some(home) = env_value(env_vars, "HOME") {
        let home = PathBuf::from(home);
        match current_os {
            zed::Os::Mac => {
                push_unique_path(
                    &mut candidates,
                    Some(
                        home.join("Library")
                            .join("Application Support")
                            .join("Zed")
                            .join("extensions")
                            .join("work")
                            .join(EXTENSION_ID),
                    ),
                );
            }
            zed::Os::Linux => {
                push_unique_path(
                    &mut candidates,
                    env_value(env_vars, "XDG_DATA_HOME").map(|data_dir| {
                        PathBuf::from(data_dir)
                            .join("zed")
                            .join("extensions")
                            .join("work")
                            .join(EXTENSION_ID)
                    }),
                );
                push_unique_path(
                    &mut candidates,
                    Some(
                        home.join(".local")
                            .join("share")
                            .join("zed")
                            .join("extensions")
                            .join("work")
                            .join(EXTENSION_ID),
                    ),
                );
            }
            zed::Os::Windows => {}
        }
    }

    candidates
}

fn env_value(env_vars: &zed::EnvVars, key: &str) -> Option<String> {
    env_vars
        .iter()
        .find(|(candidate, _)| candidate.eq_ignore_ascii_case(key))
        .map(|(_, value)| value.clone())
        .or_else(|| env::var(key).ok())
}

fn push_unique_path(paths: &mut Vec<PathBuf>, candidate: Option<PathBuf>) {
    if let Some(candidate) = candidate {
        if !paths.iter().any(|path| path == &candidate) {
            paths.push(candidate);
        }
    }
}
