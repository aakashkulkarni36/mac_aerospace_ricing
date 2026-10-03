#!/usr/bin/env bash

# Handles volume slider sync and interaction
if [ "$SENDER" = "volume_change" ]; then
  VOLUME=$(osascript -e "output volume of (get volume settings)")
  sketchybar --set "$NAME" slider.percentage="$VOLUME"
elif [ -n "$PERCENTAGE" ]; then
  osascript -e "set volume output volume $PERCENTAGE"
fi
