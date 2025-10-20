# Zed Markdoc Extension

Comprehensive [Markdoc](https://markdoc.dev) language support for the [Zed editor](https://zed.dev).

## Features

- Syntax highlighting for Markdoc documents (.mdoc, .markdoc)
- Tree-sitter based parsing using [tree-sitter-markdoc](https://github.com/louiss0/tree-sitter-markdoc)
- Code fence language injection for embedded syntax highlighting
- Folding, indentation, and bracket matching
- Support for Markdoc tags, variables, and attributes

## Installation

### From Zed Extensions (Coming Soon)

Once published to the Zed extension registry:
1. Open Zed
2. Go to Extensions
3. Search for "Markdoc"
4. Click Install

### Development Installation

1. Clone this repository
2. Symlink or copy to Zed's dev extensions directory:
   - **Linux**: `~/.config/zed/extensions/dev/markdoc`
   - **macOS**: `~/Library/Application Support/Zed/extensions/dev/markdoc`
   - **Windows**: `%APPDATA%/Zed/extensions/dev/markdoc`
3. Restart Zed

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