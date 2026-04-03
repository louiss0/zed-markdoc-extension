# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Automatic installation and startup of the official Markdoc language server
- `markdoc.config.json` support for schema-aware completions and validation

### Changed
- Added a manual trigger to the release workflow for registry update PRs

## [1.0.0] - 2025-12-17

### Added
- Publishing guide covering Zed registry submodule flow and `pnpm sort-extensions`
- Repository layout documentation clarifying distributable assets vs. local samples

### Changed
- Bumped extension and crate versions to `1.0.0` for the initial registry release
- Moved distributable assets into `extension/` so we can point the upstream `extensions.toml` entry at that path and exclude `samples/`

## [0.1.0] - 2025-10-21

### Added
- Initial Markdoc language support for Zed
- Syntax highlighting via tree-sitter-markdoc
- File associations for .mdoc and .markdoc
- Code fence language injections
- Folding and indentation support
- Sample files for testing
