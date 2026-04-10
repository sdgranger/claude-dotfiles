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

--- settings.json ---
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "[settings.json] Existing file found — backing up and replacing..."
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
  echo "  Backup saved as settings.json.bak"
fi
cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "[settings.json] Installed."

# --- statusline-command.sh ---
echo "[statusline-command.sh] Installing..."
cp "$SCRIPT_DIR/statusline-command.sh" "$CLAUDE_DIR/statusline-command.sh"
chmod +x "$CLAUDE_DIR/statusline-command.sh"

echo ""
echo "Done! Restart Claude Code to apply changes."
