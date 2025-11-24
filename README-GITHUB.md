# Mock Crypto Exchange (Flask + Electron)

**This repository contains a lightweight mock crypto-exchange web app and an Electron desktop wrapper.**

## Contents
- `app.py`, `models.py`, `auth.py`, `orders.py` — Flask backend
- `templates/` — minimal frontend (index, dashboard)
- `electron/` — electron wrapper and build configuration
- `mock_exchange_bundle.zip` — packaged project (if present)
- `build.sh` — script to package Electron app (created earlier)
- `build-windows.sh` — script to build Windows installer using `electron-builder` (generated here)
- `auto_upload.sh` — script to create a GitHub repo, push the code, create a release, and upload assets (requires `gh` CLI and `git`)

## Quick start — Web
1. Create and activate a virtualenv:
   ```bash
   python -m venv venv
   source venv/bin/activate   # on Windows: venv\Scripts\activate
   ```
2. Install Python deps:
   ```bash
   pip install -r requirements.txt
   ```
3. Initialize DB and run:
   ```bash
   python - <<PY
   from app import create_app, db
   app = create_app()
   with app.app_context():
       db.create_all()
   PY
   ./run.sh
   ```
4. Open http://localhost:5000

## Quick start — Build Windows EXE Installer (one-machine)
> You'll need Node.js (16+), npm, and Git. On Windows you'll also need Python (for some node-gyp deps) and Visual Studio Build Tools for native modules.

1. From the project root, install dependencies and build:
   ```bash
   cd electron
   npm install
   npm run build-win
   ```
2. If successful, the Windows installer `.exe` will be in `electron/dist/`.

## Auto-upload to GitHub (one command)
The included `auto_upload.sh` uses the GitHub CLI (`gh`) to create a repo, push the code, create a release, and upload two assets:
  - the project ZIP bundle
  - the Windows installer (if present)

Usage example:
```bash
chmod +x auto_upload.sh
./auto_upload.sh --user YOUR_GITHUB_USER --repo mock-exchange --tag v1.0.0 --files ../mock_exchange_bundle_with_builder.zip
```
The script will prompt/require that you are authenticated with `gh auth login` (or you can pass `--no-push` to skip pushing).

## Notes & Next steps
- Replace the `SECRET_KEY` in `app.py` with a secure value before exposing publicly.
- Use server-side sessions for production (Redis, database-backed sessions).
- Consider signing your Windows installer for best UX/trust.
- Add icons: place `icon.ico` inside `electron/` before building.

## Contact
If you want I can run the build steps for you and upload the artifacts (you'd need to provide a GitHub personal access token or authenticate `gh` locally).


## Build and Upload Helpers

- `build-windows.sh`: helper script to build a Windows installer using electron-builder.
- `auto_upload.sh`: uses `gh` CLI to create repo, push, create release and upload files.

Be sure to replace `electron/icon.ico` with a real icon before building.
