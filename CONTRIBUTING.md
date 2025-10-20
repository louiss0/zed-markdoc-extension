# Contributing to Zed Markdoc Extension

## Development Setup

1. Clone the repository
2. Install in Zed's dev extensions directory
3. Make changes to queries or configuration
4. Test with sample files in samples/

## Commit Message Format

This project follows Conventional Commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types: feat, fix, docs, style, refactor, test, chore, build, ci

Scope: markdoc (for extension-specific changes), repo (for repository setup)

## Testing

- Open sample files in Zed and verify highlighting
- Test across multiple themes
- Verify code fence injections work correctly
- Test folding and indentation

## Pull Requests

- Create feature branches from develop: `git flow feature start <feature-name>`
- Keep commits atomic and well-documented
- Update CHANGELOG.md
- Ensure all samples render correctly