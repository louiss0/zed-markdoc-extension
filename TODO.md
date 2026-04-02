# Future Enhancements & Roadmap

This document outlines planned improvements and potential features for the Zed Markdoc extension.

## Latest Findings (2026-02-24)

### Completed
- [x] Aligned `languages/markdoc/*.scm` queries with actual parser node types from `grammars/markdoc/src/node-types.json`
- [x] Replaced unsupported/non-Zed capture names with documented Zed captures
- [x] Added `languages/markdoc/brackets.scm` for Markdoc delimiters and core expression delimiters
- [x] Added/refined frontmatter YAML and Markdoc expression injections
- [x] Updated folds/indents/locals to remove stale node references

### Remaining Gaps
- [ ] Parser/docs mismatch: Markdoc docs show inline annotation syntax like `{% width="25%" %}`, but current grammar primarily models inline self-closing tag forms (`/%}`) in paragraph/list inline contexts
- [ ] Add explicit grammar coverage for annotation-style inline tags from docs and then refine highlighting/injections for those nodes

## Short-term (v0.2.x)

### Query Improvements
- [ ] More precise queries for Markdoc-specific syntax patterns
- [ ] Improve inline tag highlighting to better distinguish tag name vs. attributes
- [ ] Add support for conditional and nested expressions with better captures
- [ ] Enhance variable highlighting for complex member expressions (e.g., `$config.users[0].name`)

### Language Support
- [ ] Frontmatter injection (YAML/TOML) at the beginning of documents
- [ ] Better support for indented code blocks
- [ ] Improve link and image reference parsing

## Medium-term (v0.3.x - v1.0)

### Extension Features
- [ ] Extension icon/logo for Zed marketplace
- [ ] Snippets for common Markdoc patterns:
  - `{% callout %}` tags
  - `{% if %}` conditionals
  - `{% for %}` loops
  - Variable interpolation shortcuts
- [ ] Markdoc configuration file support (`.markdoc.js` or `markdoc.config.js`)
- [ ] Code formatting support (if applicable)

### Testing & Quality
- [ ] Automated testing for query correctness using tree-sitter test framework
- [ ] Test coverage for various Markdoc document patterns
- [ ] Consistency checks across themes (dark, light, high-contrast)

## Long-term (v1.0+)

### Distribution
- [ ] Submission to Zed extensions registry for one-click installation
- [ ] Documentation site or wiki for extension features

### Advanced Features
- [ ] Language server protocol (LSP) support for diagnostics and linting
- [ ] Support for Markdoc plugins/custom tags with dynamic highlighting
- [ ] Integration with Markdoc preview tools
- [ ] Auto-completion for common tags and variables
- [ ] Jump-to-definition for variables and includes

### Documentation
- [ ] Screenshot gallery showing extension capabilities
- [ ] GIFs demonstrating syntax highlighting across different scenarios
- [ ] Troubleshooting guide for common issues

## Known Limitations

- Currently does not support custom Markdoc plugins with dynamic syntax
- Preview functionality requires external tools (not integrated)
- Markdoc configuration files are not parsed for custom syntax definitions

## Contributing

For bug reports or feature requests, please open a GitHub issue. See CONTRIBUTING.md for development guidelines.
