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
- Automatic installation and startup of the official Markdoc language server
- `markdoc.config.json` support for schema-aware completions and validation

## Installation

### Latest Release

The latest version is **v1.0.0** - Registry Launch Release. See [releases page](https://github.com/louiss0/zed-markdoc-extension/releases) for all versions.

### From Zed Extensions

After this extension is accepted in the Zed extension registry:
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

> **Why the extra folder?** The `extension/` directory is what ships to the
> registry. Keeping samples and documentation at the repo root lets us exclude
> them from the Zed submission by pointing the upstream manifest at
> `path = "extension"`.

## Repository Layout

- `extension/` - distributable Zed extension (manifest, languages, Rust source)
- `samples/` - rich Markdoc examples for regression testing and schema fixtures
- Repository root - project metadata, workflow config, and package metadata

The separation ensures we can keep full-length samples in this branch without shipping them in the Zed registry bundle.

## Language Server Setup

This extension starts the official `@markdoc/language-server` package through
Zed's Rust extension API.

For schema-aware validation, completions, definitions, and routing, add a
`markdoc.config.json` file at your workspace root. The Markdoc language server
expects an array of server instances. Example:

```json
[
  {
    "id": "docs",
    "path": "docs/content",
    "schema": {
      "path": "docs/dist/schema.js",
      "type": "node",
      "property": "default",
      "watch": true
    },
    "routing": {
      "frontmatter": "route"
    }
  }
]
```

Without a `markdoc.config.json`, the server still starts, but it falls back to
workspace-root defaults and won't have project-specific schema information.

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

## Known Limitations

- Blockquote highlighting currently does not distinguish nested blockquote content nodes reliably; marker vs. content highlighting is still being refined.

## License

MIT License - See LICENSE file for details

## Publishing to the Zed Registry

This repository publishes from the `extension/` subdirectory so samples and
workspace-only tooling stay out of the registry package. When preparing a
release, update the extension metadata, tag the release, and let the workflow
open the upstream update PR against your `extensions` fork.

## Automated Release Flow

1. Update the extension version and changelog entries.
2. Commit the release changes, create the tag (`git tag v<new-version>`), and push the branch plus tag.
3. The `Release Markdoc Extension` GitHub Action
   ([`.github/workflows/release.yml`](.github/workflows/release.yml)) runs on
   every `v*` tag and can also be started manually with `workflow_dispatch`.
4. The workflow uses
   [`huacnlee/zed-extension-action`](https://github.com/huacnlee/zed-extension-action)
   to open the upstream PR pointing at `extension/`.

> Set the `COMMITTER_TOKEN` repository secret to a Personal Access Token with `repo` and `workflow` scopes so the workflow can push to your `extensions` fork. Without it the job will fail fast.
