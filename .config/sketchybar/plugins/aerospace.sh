#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xff38bdf8 \
    background.corner_radius=15 \
    background.height=28 \
    label.color=0xff0f172a
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    label.color=0xffcdd6f4
fi
