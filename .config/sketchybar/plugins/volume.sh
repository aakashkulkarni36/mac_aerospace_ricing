#!/usr/bin/env bash

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then
  ICON="󰝟"
  LABEL="Muted"
elif [ "$VOLUME" -gt 60 ]; then
  ICON="󰕾"
  LABEL="${VOLUME}%"
elif [ "$VOLUME" -gt 25 ]; then
  ICON="󰖀"
  LABEL="${VOLUME}%"
else
  ICON="󰕿"
  LABEL="${VOLUME}%"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
