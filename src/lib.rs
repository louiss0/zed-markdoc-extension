use std::env;
use std::path::PathBuf;

use zed::serde_json::{self, json, Value};
use zed_extension_api as zed;

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
        const PACKAGE: &str = "@markdoc/language-server";
        const VERSION: &str = "latest";
        const RELATIVE_ENTRY: &str = "node_modules/@markdoc/language-server/dist/wrapper.js";
        const NODE_MODULES_DIR: &str = "node_modules";

        // Check whether the language server is already installed and install it if needed.
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

        let mut env_vars = worktree.shell_env();
        let install_dir = env_vars
            .iter()
            .find(|(key, _)| key.eq_ignore_ascii_case("ZED_EXTENSION_WORK_DIR"))
            .map(|(_, value)| PathBuf::from(value))
            .or_else(|| env::var("ZED_EXTENSION_WORK_DIR").ok().map(PathBuf::from))
            .or_else(|| {
                env_vars
                    .iter()
                    .find(|(key, _)| key.eq_ignore_ascii_case("PWD"))
                    .map(|(_, value)| PathBuf::from(value))
            })
            .or_else(|| env::current_dir().ok());

        let install_dir = match install_dir {
            Some(path) => path,
            None => {
                let error =
                    "ZED_EXTENSION_WORK_DIR not set; cannot locate Markdoc install".to_string();
                zed::set_language_server_installation_status(
                    language_server_id,
                    &zed::LanguageServerInstallationStatus::Failed(error.clone()),
                );
                return Err(error);
            }
        };

        let script_path = install_dir.join(RELATIVE_ENTRY);
        if !script_path.exists() {
            let error = format!("markdoc-ls entrypoint missing at {}", script_path.display());
            zed::set_language_server_installation_status(
                language_server_id,
                &zed::LanguageServerInstallationStatus::Failed(error.clone()),
            );
            return Err(error);
        }

        let node_modules_dir = install_dir.join(NODE_MODULES_DIR);
        let node_path_value = node_modules_dir.to_string_lossy().into_owned();
        const PATH_SEPARATOR: &str = if cfg!(windows) { ";" } else { ":" };
        match env_vars.iter_mut().find(|(key, _)| key == "NODE_PATH") {
            Some((_, value)) => {
                if !value.is_empty() {
                    value.push_str(PATH_SEPARATOR);
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

        let script_arg = script_path.to_string_lossy().into_owned();

        Ok(zed::Command {
            command: node_binary,
            args: vec![script_arg, "--stdio".into()],
            env: env_vars,
        })
    }

    fn language_server_initialization_options(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<Option<Value>> {
        // If a markdoc.config.json exists at the project root, read it and pass it on.
        // The Markdoc server supports a "standalone" init shape and runs over --stdio.
        // We'll adapt the first entry in the array into the shape it accepts.
        let root = worktree.root_path();

        let config_path = "markdoc.config.json";
        if let Ok(contents) = worktree.read_text_file(config_path) {
            if let Ok(Value::Array(entries)) = serde_json::from_str::<Value>(&contents) {
                if let Some(Value::Object(first)) = entries.first().cloned() {
                    // Expect fields like: { id, path, schema, routing, ... }
                    let instance = Value::Object(first);
                    let path_str = instance.get("path").and_then(|v| v.as_str()).unwrap_or(".");

                    // Provide a compact "standalone" initialization object.
                    // This mirrors the README guidance and keeps the full instance
                    // under `config` so the server can access schema/routing.
                    let init = json!({
                        "root": root,
                        "path": path_str,
                        "config": instance
                    });
                    return Ok(Some(init));
                }
            }
        }

        // No config? Still initialize with a sane default rooted at the workspace.
        let init = json!({
            "root": root,
            "path": ".",
            "config": { "root": root, "path": "." }
        });
        Ok(Some(init))
    }
}

zed::register_extension!(MarkdocExtension);
