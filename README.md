KrakenDemo — Mock Kraken-style exchange learning app
---------------------------------------------------

What this package contains:
- A minimal Electron app (src/) that simulates a demo trading interface.
- package.json configured with electron-builder to produce a Windows NSIS installer.
- A GitHub Actions workflow that builds the real Windows installer on windows-latest when a Release is published.
- This environment cannot produce the Windows .exe itself; the workflow will compile it for you on GitHub Actions.

How to test locally (on your computer):
1. Install Node.js (16+ recommended) and npm.
2. In the project folder run: `npm install`
3. Run locally: `npm start`

How to build the Windows installer locally (optional):
1. Install Node.js and npm.
2. Install build tools for electron-builder on Windows (see electron-builder docs).
3. Run: `npm ci` then `npm run dist` — this will produce an NSIS installer.

How GitHub Actions will build the installer automatically:
- Add the project to your repository (commit these files to the repo root).
- Publish a Release (e.g., tag v1.0.0 and publish). The workflow will run on Windows, build the installer, and attach the produced KrakenDemo-Setup.exe to the Release.
