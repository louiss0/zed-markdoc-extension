# Publishing Markdoc to the Zed Registry

This guide documents the full workflow for publishing the Markdoc extension to the official [`zed-industries/extensions`](https://github.com/zed-industries/extensions) repository. Follow it when preparing the v1.0.0 release (and beyond).

> **Samples stay local:** Only the `extension/` subdirectory is shipped to Zed. The root-level `samples/` directory remains in this branch for testing but is excluded from the registry build via the `path = "extension"` entry in `extensions.toml`.

## Automation Cheatsheet

- Run `scripts/release.sh <version>` to bump `extension/extension.toml`, `extension/Cargo.toml`, and `CHANGELOG.md`, then compile `extension/extension.wasm`. Pass `--dry-run` to preview the steps without modifying files. The generated WASM is ignored by git so local builds never pollute commits.
- Push a `v*` tag after committing. The `Release Markdoc Extension` GitHub Action consumes that tag and invokes [`huacnlee/zed-extension-action`](https://github.com/huacnlee/zed-extension-action) with `extension-path = "extension"` so only the distributable directory lands in the upstream PR.
- The workflow requires a `COMMITTER_TOKEN` secret that points to a PAT with `repo` and `workflow` scopes. It pushes to `${{ github.repository_owner }}/extensions` by default.

## 1. Prep This Repository

1. Confirm the release version:
   - `extension/extension.toml` → `version = "1.0.0"`
   - `extension/Cargo.toml` → `version = "1.0.0"`
   - `CHANGELOG.md` lists `1.0.0`
2. Build the extension to make sure the WASM output is valid:
   ```bash
   cd extension
   cargo build --release --target wasm32-wasip1
   ```
   (Copy the resulting `extension.wasm` into `extension/` if you plan to bundle it manually.)
3. Run any local checks (formatting, linting, sample validation).

## 2. Fork & Clone the Zed Extensions Repo

```bash
git clone https://github.com/zed-industries/extensions.git
cd extensions
git checkout -b add-markdoc-extension
```

## 3. Add the Markdoc Submodule

```bash
git submodule add https://github.com/louiss0/zed-markdoc-extension.git extensions/markdoc
git add .gitmodules extensions/markdoc
```

> Use the HTTPS URL, never `git@github.com:...`.

If you want to pin to a tag/commit (recommended), check out `v1.0.0` inside the submodule:

```bash
cd extensions/markdoc
git checkout v1.0.0
cd ../..
git add extensions/markdoc
```

## 4. Update `extensions.toml`

Open the root `extensions.toml` in the Zed repo and append:

```toml
[markdoc]
submodule = "extensions/markdoc"
version = "1.0.0"
path = "extension"
```

The `path` entry ensures that only the `extension/` directory (manifest, languages, Rust source, compiled WASM) ships to Zed while `samples/` and docs remain in this branch for local reference.

## 5. Sort the Metadata

Run the required pnpm helper from the Zed repo root:

```bash
pnpm install   # first run only
pnpm sort-extensions
```

This keeps both `.gitmodules` and `extensions.toml` alphabetized, which the maintainers expect.

## 6. Commit & Open the PR

```bash
git add extensions.toml
git commit -m "feat(registry)!: add markdoc extension"
git push origin add-markdoc-extension
```

Then open a pull request against `zed-industries/extensions` describing the extension and referencing version `1.0.0`.

## 7. After Merge

Once the PR merges:

- Tag this repo (`git tag v1.0.0 && git push origin v1.0.0`) if not already done.
- Verify the extension appears in Zed's marketplace after the release pipeline packages it.

You're done! The samples stay in this branch for demos/testing, but the registry only packages `extension/`.
