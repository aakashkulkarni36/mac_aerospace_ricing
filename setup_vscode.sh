#!/usr/bin/env bash
# ==============================================================================
# VS Code Aesthetic Sync Script
# Applies true frosted glass background, darker sidebar, and Catppuccin palette.
# ==============================================================================

VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
REPO_SETTINGS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.config/vscode/settings.json"

mkdir -p "$(dirname "$REPO_SETTINGS")"
mkdir -p "$(dirname "$VSCODE_SETTINGS")"

echo "Syncing VS Code settings..."
cp "$REPO_SETTINGS" "$VSCODE_SETTINGS" 2>/dev/null || true

echo "Done! Restart VS Code to see changes."
