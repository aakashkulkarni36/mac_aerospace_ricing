#!/usr/bin/env bash

# Robust current workspace detection
CURRENT="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null || echo 1)}"

# Workspaces with open windows across all monitors
OCCUPIED=$(aerospace list-workspaces --monitor all --empty no 2>/dev/null)

IS_OCCUPIED=false
for w in $OCCUPIED; do
  if [ "$w" = "$1" ]; then
    IS_OCCUPIED=true
    break
  fi
done

if [ "$1" = "$CURRENT" ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=on \
    background.color=0xff38bdf8 \
    background.corner_radius=8 \
    background.height=20 \
    label.color=0xff0f172a \
    label.padding_left=7 \
    label.padding_right=7 \
    label.font="JetBrainsMono Nerd Font:Bold:11.5"
elif [ "$IS_OCCUPIED" = true ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=off \
    label.color=0xffcdd6f4 \
    label.padding_left=6 \
    label.padding_right=6 \
    label.font="JetBrainsMono Nerd Font:SemiBold:11.5"
else
  # Hide inactive empty workspace
  sketchybar --set "$NAME" drawing=off
fi
