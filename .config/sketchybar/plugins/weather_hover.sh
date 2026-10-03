#!/usr/bin/env bash

LOCK_FILE="/tmp/sketchybar_weather_hover"
NOW=$(date +%s%N 2>/dev/null || date +%s)

case "$SENDER" in
  "mouse.entered")
    echo "$NOW" > "$LOCK_FILE"
    sketchybar --set weather popup.drawing=on 2>/dev/null
    ;;
  "mouse.exited")
    EXIT_TIME="$NOW"
    (
      sleep 0.35
      if [ -f "$LOCK_FILE" ]; then
        ENTER_TIME=$(cat "$LOCK_FILE" 2>/dev/null || echo 0)
        if [ "$ENTER_TIME" -le "$EXIT_TIME" ]; then
          sketchybar --set weather popup.drawing=off 2>/dev/null
          rm -f "$LOCK_FILE" 2>/dev/null
        fi
      else
        sketchybar --set weather popup.drawing=off 2>/dev/null
      fi
    ) &
    ;;
  "mouse.clicked")
    CURRENT_STATE=$(sketchybar --query weather | jq -r '.popup.drawing' 2>/dev/null || echo "off")
    if [ "$CURRENT_STATE" = "on" ]; then
      sketchybar --set weather popup.drawing=off 2>/dev/null
      rm -f "$LOCK_FILE" 2>/dev/null
    else
      echo "$NOW" > "$LOCK_FILE"
      sketchybar --set weather popup.drawing=on 2>/dev/null
    fi
    ;;
esac
