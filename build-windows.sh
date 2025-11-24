#!/usr/bin/env bash
set -euo pipefail
echo "Building Windows installer with electron-builder..."
cd electron
npm install
npx electron-builder --windows --x64 --publish never
echo "Windows installer build completed. Look in electron/dist/"
