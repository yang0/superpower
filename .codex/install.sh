#!/usr/bin/env bash
set -euo pipefail

NAME="${1:-superpowers}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/skills"
TARGET_DIR="$HOME/.agents/skills/$NAME"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Skills directory not found: $SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$HOME/.agents/skills"

if [[ -e "$TARGET_DIR" ]]; then
  echo "Target already exists: $TARGET_DIR" >&2
  echo "Remove it first or choose a different name: bash .codex/install.sh <name>" >&2
  exit 1
fi

ln -s "$SOURCE_DIR" "$TARGET_DIR"

echo "Installed superpowers skills:"
echo "  $TARGET_DIR -> $SOURCE_DIR"
echo "Restart Codex CLI to load the skills."
