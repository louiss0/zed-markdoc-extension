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

The latest version is **v0.1.0** - Initial Release. See [releases page](https://github.com/louiss0/zed-markdoc-extension/releases) for all versions.

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

2. Symlink or copy to Zed's dev extensions directory:
   - **Linux**: `ln -s /path/to/zed-markdoc-extension ~/.config/zed/extensions/dev/markdoc`
   - **macOS**: `ln -s /path/to/zed-markdoc-extension ~/Library/Application\ Support/Zed/extensions/dev/markdoc`
   - **Windows**: `mklink /D "%APPDATA%\Zed\extensions\dev\markdoc" "C:\path\to\zed-markdoc-extension"`

3. Restart Zed

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

## Publishing to the Zed Registry

Zed publishes extensions from PRs to the [`zed-industries/extensions`](https://github.com/zed-industries/extensions) repository.

1. Fork `zed-industries/extensions` to your account.
2. Add this repository as a submodule in your fork (HTTPS URL required):
   ```bash
   git submodule add https://github.com/louiss0/zed-markdoc-extension.git extensions/markdoc
   git add extensions/markdoc
   ```
3. Add this entry to your fork's top-level `extensions.toml`:
   ```toml
   [markdoc]
   submodule = "extensions/markdoc"
   version = "0.1.0"
   ```
4. Run `pnpm sort-extensions` in the `zed-industries/extensions` repo.
5. Open a PR from your fork to `zed-industries/extensions`.

## Automating Registry Update PRs

This repository now includes [`.github/workflows/release.yml`](.github/workflows/release.yml), powered by [`huacnlee/zed-extension-action@v2`](https://github.com/huacnlee/zed-extension-action), to automate update PRs to `zed-industries/extensions` on each release tag.

Before using the workflow:

1. Fork `zed-industries/extensions` to `louiss0/extensions`.
2. Create a GitHub personal access token with `repo` and `workflow` scopes.
3. Add that token in this repo as the `COMMITTER_TOKEN` Actions secret.

Then publish by tagging:

```bash
git tag v0.1.1
git push origin v0.1.1
```

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
