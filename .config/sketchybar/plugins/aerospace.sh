#!/usr/bin/env bash

# Highlight the active workspace in SketchyBar
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on \
                           background.color=0xff7aa2f7 \
                           label.color=0xff15161e \
                           icon.color=0xff15161e
else
  sketchybar --set "$NAME" background.drawing=off \
                           label.color=0xffc0caf5 \
                           icon.color=0xff7aa2f7
fi
