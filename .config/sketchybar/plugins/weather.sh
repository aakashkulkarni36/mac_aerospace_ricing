#!/usr/bin/env bash

TARGET_NAME="${NAME:-weather}"
CACHE_FILE="/tmp/sketchybar_weather_cache.txt"

# Try fetching fresh data with 4s timeout
WEATHER_DATA=$(curl -s --max-time 4 "https://wttr.in/?format=%c|%t|%l&m" 2>/dev/null)

if [ -n "$WEATHER_DATA" ] && [[ "$WEATHER_DATA" == *"|"* ]] && [[ "$WEATHER_DATA" != *"Unknown location"* ]] && [[ "$WEATHER_DATA" != *"503"* ]] && [[ "$WEATHER_DATA" != *"<html>"* ]]; then
  echo "$WEATHER_DATA" > "$CACHE_FILE"
elif [ -f "$CACHE_FILE" ]; then
  WEATHER_DATA=$(cat "$CACHE_FILE")
fi

if [ -n "$WEATHER_DATA" ] && [[ "$WEATHER_DATA" == *"|"* ]]; then
  ICON=$(echo "$WEATHER_DATA" | cut -d'|' -f1 | tr -d '[:space:]')
  TEMP=$(echo "$WEATHER_DATA" | cut -d'|' -f2 | tr -d '[:space:]' | sed 's/^+//')
  LOC=$(echo "$WEATHER_DATA" | cut -d'|' -f3 | cut -d',' -f1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  [ -z "$ICON" ] && ICON="󰖐"

  if [ -n "$TEMP" ]; then
    LABEL="$TEMP"
    [ -n "$LOC" ] && LABEL="$TEMP $LOC"
    sketchybar --set "$TARGET_NAME" label="$LABEL" icon="$ICON"
  else
    sketchybar --set "$TARGET_NAME" label="Offline" icon="󰖐"
  fi
else
  sketchybar --set "$TARGET_NAME" label="Offline" icon="󰖐"
fi
