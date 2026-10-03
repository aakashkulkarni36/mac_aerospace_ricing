#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"
[ -f "$HOME/.config/sketchybar/current_theme.sh" ] && source "$HOME/.config/sketchybar/current_theme.sh"
NAME="${NAME:-front_app}"
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

APP_NAME="${INFO:-$(aerospace list-windows --focused --format "%{app-name}" 2>/dev/null)}"
[ -z "$APP_NAME" ] && APP_NAME="Desktop"

alias_app="$APP_NAME"
case "$alias_app" in
  "Chrome") alias_app="Google Chrome" ;;
  "VS Code" | "Visual Studio Code" | "Cursor") alias_app="Code" ;;
  "kitty" | "Kitty") alias_app="kitty" ;;
esac

__icon_map "$alias_app"

if [ "$icon_result" != ":default:" ]; then
  sketchybar --set "$NAME" \
    icon="$icon_result" \
    icon.font="sketchybar-app-font:Regular:15.0" \
    icon.color="${THEME_ACCENT1:-0xff38bdf8}" \
    label="$APP_NAME"
else
  sketchybar --set "$NAME" \
    icon="󱂬" \
    icon.font="JetBrainsMono Nerd Font Propo:Bold:16.0" \
    icon.color="${THEME_ACCENT1:-0xff38bdf8}" \
    label="$APP_NAME"
fi
