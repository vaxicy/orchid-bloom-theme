# Packaging

Run `scripts/package.ps1 -Force` (or without `-Force` when no archive with that version exists yet):

```
powershell -ExecutionPolicy Bypass -File scripts/package.ps1 -Force
```

The script writes a complete ZIP to the default folder `D:\迅雷下载\vibe coding` as `orchid-bloom-theme-<version>.zip`, derived from the project location rather than hard-coded, with `manifest.json` at the archive root.

Packed: `manifest.json`, `logo/`, `README.md`, `LICENSE`, `PACKAGING.md`, `scripts/`, `store-assets/`, `.gitignore`.
Never packed: local AI data (`.codebuddy/`), Chrome's generated `Cached Theme.pak`, old `*.zip` archives, `__pycache__/`.

After compressing, the script re-reads `manifest.json` from inside the finished archive, verifies that every file the manifest references is present, and fails if `manifest.json` is not at the archive root — so a structurally wrong ZIP is caught at build time instead of at upload time.

Store screenshots and promo tiles travel inside the ZIP for reference but are uploaded separately in the Chrome Web Store listing form.
