#!/bin/bash
# multi-codex installer for macOS and Linux.

set -euo pipefail

RAW="https://raw.githubusercontent.com/opendaniil/multi-codex/main/multi-codex"
INSTALL_DIR="/usr/local/bin"

step() { echo "  -> $1"; }
abort() { echo "Error: $1" >&2; exit 1; }

case "$(uname -s)" in
  Darwin | Linux) ;;
  *) abort "unsupported platform. This installer supports macOS and Linux." ;;
esac

command -v curl >/dev/null 2>&1 || abort "curl is required"

if [ ! -w "$INSTALL_DIR" ]; then
  INSTALL_DIR="$HOME/.local/bin"
  mkdir -p "$INSTALL_DIR"
fi

echo "Installing multi-codex to $INSTALL_DIR ..."
step "Downloading multi-codex"
curl -fsSL "$RAW" -o "$INSTALL_DIR/multi-codex"
chmod +x "$INSTALL_DIR/multi-codex"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
  echo ""
  echo "Add this directory to your PATH:"
  echo "  $INSTALL_DIR"
fi

echo ""
echo "multi-codex installed."
echo "Try:"
echo "  multi-codex help"
echo "  multi-codex new work"
