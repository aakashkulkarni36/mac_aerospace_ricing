#!/usr/bin/env bash

# Aerospace workspace indicator for SketchyBar
# - Clean, legible space number badge
# - Dynamic app glyphs for all workspaces with open windows (not just active)
# - Balanced contrast matching Catppuccin / Hyprland frosted aesthetic

SID="${1:-${NAME#space.}}"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null || echo 1)}"
OCCUPIED=$(aerospace list-workspaces --monitor all --empty no 2>/dev/null)

IS_OCCUPIED=false
for w in $OCCUPIED; do
  if [ "$w" = "$SID" ]; then
    IS_OCCUPIED=true
    break
  fi
done

# If workspace is neither active nor occupied, hide it
if [ "$SID" != "$FOCUSED" ] && [ "$IS_OCCUPIED" = false ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

# Load app icon mapping
ICONS=""
if [ -f "$HOME/.config/sketchybar/plugins/icon_map.sh" ]; then
  source "$HOME/.config/sketchybar/plugins/icon_map.sh"
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    __icon_map "$app"
    ICONS="${ICONS}${icon_result} "
  done < <(aerospace list-windows --workspace "$SID" --format "%{app-name}" 2>/dev/null | sort -u)
  ICONS="${ICONS% }"
fi

if [ "$SID" = "$FOCUSED" ]; then
  # Active workspace:
  # Frosted cyan border + translucent sky blue background with white font
  if [ -n "$ICONS" ]; then
    LABEL_STR="$SID  $ICONS"
  else
    LABEL_STR="$SID"
  fi

  sketchybar --set "$NAME" \
    drawing=on \
    icon.drawing=off \
    label="$LABEL_STR" \
    label.drawing=on \
    label.font="sketchybar-app-font:Regular:12.0" \
    label.color=0xffffffff \
    label.padding_left=8 \
    label.padding_right=8 \
    background.drawing=on \
    background.color=0x4038bdf8 \
    background.border_color=0x8038bdf8 \
    background.border_width=1 \
    background.corner_radius=8 \
    background.height=24
else
  # Inactive occupied workspace:
  # Translucent muted slate background with silver icons
  if [ -n "$ICONS" ]; then
    LABEL_STR="$SID  $ICONS"
  else
    LABEL_STR="$SID"
  fi

  sketchybar --set "$NAME" \
    drawing=on \
    icon.drawing=off \
    label="$LABEL_STR" \
    label.drawing=on \
    label.font="sketchybar-app-font:Regular:12.0" \
    label.color=0xff94a3b8 \
    label.padding_left=7 \
    label.padding_right=7 \
    background.drawing=on \
    background.color=0x251e293b \
    background.border_color=0x30475569 \
    background.border_width=1 \
    background.corner_radius=8 \
    background.height=24
fi
