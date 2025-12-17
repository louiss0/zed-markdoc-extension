# Zed Markdoc Extension

[![Release](https://img.shields.io/github/v/release/louiss0/zed-markdoc-extension?include_prereleases)](https://github.com/louiss0/zed-markdoc-extension/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Repo](https://img.shields.io/badge/GitHub-Repository-blue)](https://github.com/louiss0/zed-markdoc-extension)

Comprehensive [Markdoc](https://markdoc.dev) language support for the [Zed editor](https://zed.dev).

## Features

- Syntax highlighting for Markdoc documents (.mdoc, .markdoc)
- Tree-sitter based parsing using [tree-sitter-markdoc](https://github.com/louiss0/tree-sitter-markdoc)
- Code fence language injection for embedded syntax highlighting
- Folding, indentation, and bracket matching
- Support for Markdoc tags, variables, and attributes

## Installation

### Latest Release

The latest version is **v1.0.0** - Registry Launch Release. See [releases page](https://github.com/louiss0/zed-markdoc-extension/releases) for all versions.

### From Zed Extensions (Coming Soon)

Once published to the Zed extension registry:
1. Open Zed
2. Go to Extensions
3. Search for "Markdoc"
4. Click Install

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/louiss0/zed-markdoc-extension.git
   ```

2. Symlink or copy the `extension/` subdirectory to Zed's dev extensions directory:
   - **Linux**: `ln -s /path/to/zed-markdoc-extension/extension ~/.config/zed/extensions/dev/markdoc`
   - **macOS**: `ln -s /path/to/zed-markdoc-extension/extension ~/Library/Application\ Support/Zed/extensions/dev/markdoc`
   - **Windows**: `mklink /D "%APPDATA%\Zed\extensions\dev\markdoc" "C:\path\to\zed-markdoc-extension\extension"`

3. Restart Zed

> **Why the extra folder?** The `extension/` directory is what ships to the registry. Keeping samples and documentation at the repo root lets us exclude them from the Zed submission by pointing the registry to `path = "extension"` (see `PUBLISHING.md`).

## Repository Layout

- `extension/` – distributable Zed extension (manifest, languages, Rust source)
- `samples/` – rich Markdoc examples for regression testing and screenshots; local only
- `docs/` – publishing and contribution guidelines (`PUBLISHING.md`, `CONTRIBUTING.md`)
- Everything else – project metadata (CHANGELOG, README, LICENSE, etc.)

The separation ensures we can keep full-length samples in this branch without shipping them in the Zed registry bundle.

## File Associations

By default, this extension handles:
- `.mdoc` files
- `.markdoc` files

### Using Markdoc for .md Files (Opt-in)

To avoid conflicts with standard Markdown, `.md` files are NOT associated by default.

To use Markdoc highlighting for specific .md files, add to your Zed settings:

```json
{
  "file_types": {
    "Markdoc": ["**/*.markdoc.md", "content/**/*.md"]
  }
}
```

## Credits

- Grammar: [tree-sitter-markdoc](https://github.com/louiss0/tree-sitter-markdoc)
- Extension developed for Zed editor

## License

MIT License - See LICENSE file for details

## Publishing to the Zed Registry

Step-by-step instructions for opening the upstream PR (submodule, `extensions.toml`, `pnpm sort-extensions`, etc.) live in [`PUBLISHING.md`](PUBLISHING.md). Follow that guide when preparing the 1.0.0 submission so `samples/` stay local while `extension/` gets packaged.

## Automated Release Flow

1. Run `scripts/release.sh <new-version>` to bump manifests/CHANGELOG, build the WASM, and prepare the tag. Use `--dry-run` to preview the steps without touching files.
2. Commit the changes, create the tag (`git tag v<new-version>`), and push tag + commits.
3. The `Release Markdoc Extension` GitHub Action (`.github/workflows/release.yml`) fires on every `v*` tag. It uses [`huacnlee/zed-extension-action`](https://github.com/huacnlee/zed-extension-action) to open/merge the upstream PR pointing at `extension/`.

> Set the `COMMITTER_TOKEN` repository secret to a Personal Access Token with `repo` and `workflow` scopes so the workflow can push to your `extensions` fork. Without it the job will fail fast.
