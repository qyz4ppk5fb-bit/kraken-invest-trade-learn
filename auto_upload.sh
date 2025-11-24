#!/usr/bin/env bash
set -euo pipefail
show_help() {
  cat <<EOF
auto_upload.sh -- Create GitHub repo, push code, create release, upload assets.

Requires: git, gh (GitHub CLI)

Usage:
  ./auto_upload.sh --user <github-user> --repo <repo-name> --tag <tag> --files <comma-separated-file-paths> [--no-push]

Example:
  ./auto_upload.sh --user billy --repo mock-exchange --tag v1.0.0 --files "/path/to/mock_exchange_bundle_with_builder.zip,./electron/dist/MockExchange Setup.exe"
EOF
}

if [ "$#" -lt 1 ]; then
  show_help
  exit 1
fi

USER=""
REPO=""
TAG="v0.1.0"
FILES=""
NO_PUSH=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --user) USER="$2"; shift 2 ;;
    --repo) REPO="$2"; shift 2 ;;
    --tag) TAG="$2"; shift 2 ;;
    --files) FILES="$2"; shift 2 ;;
    --no-push) NO_PUSH=1; shift 1 ;;
    --help) show_help; exit 0 ;;
    *) echo "Unknown arg: $1"; show_help; exit 1 ;;
  esac
done

if [ -z "$USER" ] || [ -z "$REPO" ] || [ -z "$FILES" ]; then
  echo "--user, --repo and --files are required"
  exit 1
fi

set -x
# create repo if not exists
if ! gh repo view ${USER}/${REPO} >/dev/null 2>&1; then
  gh repo create ${USER}/${REPO} --public --confirm
fi

# initialize git if needed
if [ ! -d .git ]; then
  git init
  git add .
  git commit -m "Initial commit"
  if [ $NO_PUSH -eq 0 ]; then
    git branch -M main
    git remote add origin https://github.com/${USER}/${REPO}.git
    git push -u origin main
  fi
else
  git add .
  git commit -m "Update" || echo "no changes to commit"
  if [ $NO_PUSH -eq 0 ]; then
    git push origin main || git push -u origin main
  fi
fi

# create release
gh release create ${TAG} --title "${TAG}" --notes "Release ${TAG}" || echo "release exists or failed"

# upload files (comma separated)
IFS=',' read -ra PATHS <<< "$FILES"
for p in "${PATHS[@]}"; do
  if [ -f "$p" ]; then
    gh release upload ${TAG} "$p" || echo "upload failed for $p"
  else
    echo "File not found: $p"
  fi
done

echo "Done. Release: https://github.com/${USER}/${REPO}/releases/tag/${TAG}"
