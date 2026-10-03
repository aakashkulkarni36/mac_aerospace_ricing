#!/usr/bin/env bash

TARGET="${NAME:-volume}"

# Handle mouse scroll adjustment directly over the volume pill
if [ "$SENDER" = "mouse.scrolled" ]; then
  DELTA="${SCROLL_DELTA:-0}"
  if [ "$DELTA" -gt 0 ]; then
    osascript -e "set volume output volume ((output volume of (get volume settings)) + 4)" 2>/dev/null
  elif [ "$DELTA" -lt 0 ]; then
    osascript -e "set volume output volume ((output volume of (get volume settings)) - 4)" 2>/dev/null
  fi
  exit 0
fi

# Use $INFO directly if passed by volume_change to avoid AppleScript execution
if [ -n "$INFO" ]; then
  VOLUME="$INFO"
else
  VOLUME=$(osascript -e "output volume of (get volume settings)" 2>/dev/null)
  [ -z "$VOLUME" ] && VOLUME="50"
fi

# Check muted status quickly
MUTED=$(osascript -e "output muted of (get volume settings)" 2>/dev/null)

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then
  ICON="󰝟"
  LABEL="Muted"
  COLOR="0xff6c7086"
elif [ "$VOLUME" -gt 60 ]; then
  ICON="󰕾"
  LABEL="${VOLUME}%"
  COLOR="0xfff9e2af"
elif [ "$VOLUME" -gt 25 ]; then
  ICON="󰖀"
  LABEL="${VOLUME}%"
  COLOR="0xfff9e2af"
else
  ICON="󰕿"
  LABEL="${VOLUME}%"
  COLOR="0xfff9e2af"
fi

sketchybar --set "$TARGET" icon="$ICON" icon.color="$COLOR" label="$LABEL"
