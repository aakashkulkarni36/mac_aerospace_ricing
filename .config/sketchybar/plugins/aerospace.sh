#!/usr/bin/env bash

# Aerospace workspace indicator for SketchyBar
# - Space number rendered in JetBrainsMono Nerd Font Propo
# - App glyphs rendered using authentic sketchybar-app-font icons via icon_map.sh
# - Seamless visual hierarchy between active, occupied, and empty workspaces

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

SID="${1:-${NAME#space.}}"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null || echo 1)}"

# Get unique non-empty windows on this workspace
WINS=$(aerospace list-windows --workspace "$SID" --format "%{app-name}" 2>/dev/null | grep -v '^$' | sort -u)

# If workspace is neither active nor occupied, hide it
if [ "$SID" != "$FOCUSED" ] && [ -z "$WINS" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

# Map application names directly using icon_map
ICONS=""
if [ -n "$WINS" ]; then
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    alias_app="$app"
    case "$alias_app" in
      "Chrome") alias_app="Google Chrome" ;;
      "VS Code" | "Visual Studio Code" | "Cursor") alias_app="Code" ;;
      "kitty" | "Kitty") alias_app="kitty" ;;
    esac
    __icon_map "$alias_app"
    ICONS="${ICONS}${icon_result} "
  done <<< "$WINS"
  ICONS="${ICONS% }"
fi

if [ "$SID" = "$FOCUSED" ]; then
  # Active workspace:
  if [ -n "$ICONS" ]; then
    sketchybar --set "$NAME" \
      drawing=on \
      icon="$SID" \
      icon.drawing=on \
      icon.font="JetBrainsMono Nerd Font Propo:ExtraBold:13.5" \
      icon.color=0xffffffff \
      icon.padding_left=8 \
      icon.padding_right=5 \
      label="$ICONS" \
      label.drawing=on \
      label.font="sketchybar-app-font:Regular:14.0" \
      label.color=0xffffffff \
      label.padding_left=0 \
      label.padding_right=8 \
      background.drawing=on \
      background.color=0x4038bdf8 \
      background.border_color=0x8038bdf8 \
      background.border_width=1 \
      background.corner_radius=8 \
      background.height=24
  else
    sketchybar --set "$NAME" \
      drawing=on \
      icon="$SID" \
      icon.drawing=on \
      icon.font="JetBrainsMono Nerd Font Propo:ExtraBold:13.5" \
      icon.color=0xffffffff \
      icon.padding_left=8 \
      icon.padding_right=8 \
      label.drawing=off \
      background.drawing=on \
      background.color=0x4038bdf8 \
      background.border_color=0x8038bdf8 \
      background.border_width=1 \
      background.corner_radius=8 \
      background.height=24
  fi
else
  # Inactive occupied workspace:
  if [ -n "$ICONS" ]; then
    sketchybar --set "$NAME" \
      drawing=on \
      icon="$SID" \
      icon.drawing=on \
      icon.font="JetBrainsMono Nerd Font Propo:Bold:13.5" \
      icon.color=0xff94a3b8 \
      icon.padding_left=7 \
      icon.padding_right=5 \
      label="$ICONS" \
      label.drawing=on \
      label.font="sketchybar-app-font:Regular:14.0" \
      label.color=0xff94a3b8 \
      label.padding_left=0 \
      label.padding_right=7 \
      background.drawing=on \
      background.color=0x251e293b \
      background.border_color=0x30475569 \
      background.border_width=1 \
      background.corner_radius=8 \
      background.height=24
  else
    sketchybar --set "$NAME" \
      drawing=on \
      icon="$SID" \
      icon.drawing=on \
      icon.font="JetBrainsMono Nerd Font Propo:Bold:13.5" \
      icon.color=0xff94a3b8 \
      icon.padding_left=7 \
      icon.padding_right=7 \
      label.drawing=off \
      background.drawing=on \
      background.color=0x251e293b \
      background.border_color=0x30475569 \
      background.border_width=1 \
      background.corner_radius=8 \
      background.height=24
  fi
fi
