#!/usr/bin/env bash

# Smart Dynamic Workspaces:
# Always show workspace if:
# 1. It is the currently focused workspace, OR
# 2. It contains open windows (non-empty workspace)
OCCUPIED=$(aerospace list-workspaces --monitor focused --empty no 2>/dev/null)
CURRENT="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null || echo 1)}"

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
    background.corner_radius=15 \
    background.height=28 \
    label.color=0xff0f172a
elif [ "$IS_OCCUPIED" = true ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=off \
    label.color=0xffcdd6f4
else
  # Empty workspace that is not active: keep it hidden for clean look
  sketchybar --set "$NAME" drawing=off
fi
