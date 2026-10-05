<p align="center">
  <img src="https://raw.githubusercontent.com/vaxicy/orchid-bloom-theme/main/logo/logo128.png" width="128" alt="Orchid Bloom Theme icon">
</p>

<h1 align="center">Orchid Bloom Theme</h1>

<p align="center">A calm pastel Chrome theme in dusty orchid, pale lilac and soft warm white.</p>

<p align="center">
  <img src="https://img.shields.io/badge/Chrome%20Web%20Store-theme-blue?logo=googlechrome" alt="Chrome Web Store">
  <img src="https://img.shields.io/badge/version-1.0.0-blue" alt="version">
  <img src="https://img.shields.io/badge/license-Non--Commercial-lightgrey" alt="license">
</p>

## About

Orchid Bloom brings a gentle bloom to the browser. A dusty orchid frame wraps the top of the window, the toolbar and active tab soften into pale lilac, and the new tab page opens on warm white so the page you are reading stays the brightest thing on screen. Muted lilac marks the new tab header and every link, while a deep mauve ink carries tab titles, bookmark labels, toolbar icons and the address bar. The design is flat colour throughout — no wallpaper, no textures, no gradients — and the icon distills it into a single five-petal orchid blossom on a transparent ground.

## Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Dusty Orchid | `#B7A4C2` | Window frame (active and inactive) and window button background |
| Muted Lilac | `#9779A6` | New tab page header and links |
| Pale Lilac | `#EDE5EF` | Toolbar, active tab, bookmarks bar |
| Warm White | `#FAF7F9` | New tab page background |
| Soft Warm White | `#FFFCFE` | Omnibox (address bar) field |
| Deep Mauve Ink | `#514653` | Tab, bookmark, toolbar and new-tab text, toolbar icons |
| Soft Mauve | `#D8C3D5` | Accent tone used in the store artwork |
| Petal Blush | `#F0E1E8` | Accent tone used in the store artwork |

The four tones on the store introduction card — Dusty Orchid, Muted Lilac, Soft Mauve and Petal Blush — are the palette the theme is built from; Soft Mauve and Petal Blush appear as accents in the artwork rather than as separate UI roles. Deep mauve ink carries all small text, because a pastel orchid at this lightness is too low-contrast to read at 12–13px. Window button glyphs, hover states and separators are drawn by Chrome and Windows.

## Features

- Dusty orchid frame with a pale lilac toolbar and active tab for soft, readable browser chrome.
- Flat, solid colour design with no wallpaper, textures or gradients.
- Muted lilac new tab header and links, tuned against warm white.
- Deep mauve ink for tab titles, bookmark labels, toolbar icons and address-bar text.
- One continuous frame colour whether the window is focused or not.
- Single-tone Google wordmark drawn by Chrome itself through `ntp_logo_alternate`; it reads as a soft mauve, close to `#C19BB4`.
- Pure theme: no scripts, no permissions, nothing collected.

## Install

### From source (unpacked)

1. Download or clone this repository.
2. Open Chrome and navigate to `chrome://extensions`.
3. Enable **Developer mode** in the top-right corner.
4. Click **Load unpacked** and select this folder.
5. The theme applies immediately; reset it any time under Settings, then Appearance, then Themes.

### From the Chrome Web Store

The store listing is in preparation. Until it is live, load the unpacked copy with the steps above.

## Preview

![Orchid Bloom Theme browser preview](https://raw.githubusercontent.com/vaxicy/orchid-bloom-theme/main/store-assets/screenshots/en/screenshot-1-browser.png)

![Orchid Bloom Theme color palette](https://raw.githubusercontent.com/vaxicy/orchid-bloom-theme/main/store-assets/screenshots/en/screenshot-2-introduction.png)

### Store promo tiles

![Orchid Bloom Theme marquee](https://raw.githubusercontent.com/vaxicy/orchid-bloom-theme/main/store-assets/promo/1400x560.png)

<p align="center">
  <img src="https://raw.githubusercontent.com/vaxicy/orchid-bloom-theme/main/store-assets/promo/440x280.png" width="440" alt="Orchid Bloom Theme promo tile">
</p>

These are illustrative HTML/CSS layouts rendered by headless Chromium from the exact `manifest.json` colours, calibrated against a real installed Chrome session. They are not native Chrome captures, so the fine details — window glyphs, hover states, and the tinted Google wordmark — follow your own browser and OS after install.

## Files

| File | Description |
|------|-------------|
| `manifest.json` | Chrome theme manifest (MV3) with an inline `theme` block — single source of truth for every colour |
| `logo/logo128.png` | Theme and store icon, 128x128, the only size the manifest references |
| `store-assets/screenshots/en/` | Store listing screenshots (1280x800) |
| `store-assets/promo/` | Promo tiles (440x280 and 1400x560) |
| `store-assets/references/` | The browser and promo mock-up HTML plus their PNG renders |
| `store-assets/store-description.txt` | Store listing description (English) |
| `store-assets/ASSET-NOTES.md` | How the store artwork is composed and calibrated |
| `scripts/` | Generators: layout references, store assets, release ZIP |
| `PACKAGING.md` | How the upload ZIP is built |
| `LICENSE` | Non-Commercial License (bilingual) |

## Regenerating the assets

```
pip install -r scripts/requirements.txt
playwright install chromium

python3 scripts/generate-store-assets.py
```

One composer renders all four store assets — both screenshots, both promo tiles, and the HTML sources in `store-assets/references/` — so a style change is made in the script and re-rendered, never patched onto a PNG. The script also asserts that the logo is exactly 128x128.

## Packaging

```
powershell -ExecutionPolicy Bypass -File scripts/package.ps1 -Force
```

Writes a complete ZIP named `orchid-bloom-theme-<version>.zip` to the default folder `D:\迅雷下载\vibe coding`, with `manifest.json` at the archive root. `-Force` overwrites any existing archive. Promo tiles and screenshots travel inside the ZIP but are uploaded separately in the Chrome Web Store listing form.

## License

Non-Commercial License — personal use permitted, commercial use requires permission. See [LICENSE](LICENSE).
