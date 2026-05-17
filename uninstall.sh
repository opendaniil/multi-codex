#!/bin/bash
# multi-codex uninstaller for macOS and Linux.

set -euo pipefail

step() { echo "  -> $1"; }
abort() { echo "Error: $1" >&2; exit 1; }

resolved_dir() {
  local target="$1"
  if [ -z "$target" ] || [ ! -d "$target" ]; then
    return 1
  fi
  (cd -P "$target" >/dev/null 2>&1 && pwd)
}

check_profile_base() {
  local base="$1"
  local resolved_base
  local resolved_home

  [ -n "$base" ] || abort "refusing to delete an empty profile data path"
  [ "$base" != "/" ] || abort "refusing to delete filesystem root"

  resolved_base="$(resolved_dir "$base")" || abort "profile data path does not exist or is not a directory: $base"
  resolved_home="$(resolved_dir "$HOME")" || abort "could not resolve home directory"

  [ "$resolved_base" != "/" ] || abort "refusing to delete filesystem root"
  [ "$resolved_base" != "$resolved_home" ] || abort "refusing to delete user home directory"
  [ "$base" != "$HOME" ] || abort "refusing to delete user home directory"
  [ "$base" != "$HOME/" ] || abort "refusing to delete user home directory"

  if [ ${#resolved_base} -lt 6 ]; then
    abort "refusing to delete broad profile data path: $resolved_base"
  fi
}

echo "Uninstalling multi-codex..."

removed=false
for candidate in /usr/local/bin/multi-codex "$HOME/.local/bin/multi-codex"; do
  if [ -f "$candidate" ]; then
    step "Removing $candidate"
    rm -f "$candidate"
    removed=true
  fi
done

if [ "$removed" = false ]; then
  echo "  multi-codex was not found."
fi

BASE="$HOME/.multi-codex"
if [ -d "$BASE" ]; then
  check_profile_base "$BASE"
  echo ""
  read -r -p "Delete all profile data in $BASE? [y/N] " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    step "Removing $BASE"
    rm -rf "$BASE"
  else
    echo "  Profile data kept at $BASE"
  fi
fi

echo "multi-codex uninstalled."
