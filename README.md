
# Kraken Invest — Mock Crypto Exchange

This repository is prepared for GitHub:

**Owner**: lw5388979-wq  
**Repo**: kraken-invest-trade-learn  
**GitHub Pages URL**: https://lw5388979-wq.github.io/kraken-invest-trade-learn/

## What is included
- Full mock exchange web + electron desktop bundle in `release/mock_exchange_bundle_full_release.zip`
- `index.html` — download page (used for GitHub Pages)
- `install_instructions.pdf`
- `auto_upload.sh` — helper to push to GitHub and upload release assets
- `build-windows.sh` — helper to build a Windows installer using electron-builder

## Quick publish steps (recommended)
1. Unzip this package locally.
2. Authenticate gh CLI: `gh auth login`
3. Run the auto-upload script to create the repo, push code, and upload release assets:

```bash
chmod +x auto_upload.sh
./auto_upload.sh --user lw5388979-wq --repo kraken-invest-trade-learn --tag v1.0.0 --files "release/mock_exchange_bundle_full_release.zip"
```

4. In GitHub, enable Pages for the repo (Settings → Pages → select `main` branch, `/root` folder). After a few minutes, https://lw5388979-wq.github.io/kraken-invest-trade-learn/ will be live.

## Notes
- Replace `electron/icon.ico` with a real icon before building installers.
- For signing Windows installers consider an EV code signing certificate to avoid SmartScreen warnings.
