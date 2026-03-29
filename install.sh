#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Code Dotfiles Installer ==="
echo ""
echo "Source:  $SCRIPT_DIR"
echo "Target:  $CLAUDE_DIR"
echo ""

# Ensure ~/.claude exists
mkdir -p "$CLAUDE_DIR"

# Check for jq dependency
if ! command -v jq &>/dev/null; then
  echo "[ERROR] jq is required for the status line. Install it first:"
  echo "  macOS:  brew install jq"
  echo "  Ubuntu: sudo apt install jq"
  exit 1
fi

# --- settings.json ---
# Merge strategy: if settings.json already exists, merge our keys into it
# (preserves any machine-specific additions like permissions)
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "[settings.json] Existing file found — merging..."
  # Backup existing
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
  # Deep merge: repo settings take priority
  jq -s '.[0] * .[1]' "$CLAUDE_DIR/settings.json" "$SCRIPT_DIR/settings.json" \
    > "$CLAUDE_DIR/settings.json.tmp"
  mv "$CLAUDE_DIR/settings.json.tmp" "$CLAUDE_DIR/settings.json"
  echo "  Backup saved as settings.json.bak"
else
  echo "[settings.json] Installing..."
  cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
fi

# --- statusline-command.sh ---
echo "[statusline-command.sh] Installing..."
cp "$SCRIPT_DIR/statusline-command.sh" "$CLAUDE_DIR/statusline-command.sh"
chmod +x "$CLAUDE_DIR/statusline-command.sh"

echo ""
echo "Done! Restart Claude Code to apply changes."
