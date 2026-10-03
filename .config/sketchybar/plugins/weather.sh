#!/usr/bin/env bash

# Fetch dynamic weather in Celsius based on current IP/GPS geolocation
WEATHER_DATA=$(curl -s --max-time 4 "https://wttr.in/?format=%c|%t|%l&m" 2>/dev/null)

if [ -n "$WEATHER_DATA" ]; then
  ICON=$(echo "$WEATHER_DATA" | cut -d'|' -f1 | tr -d '[:space:]')
  TEMP=$(echo "$WEATHER_DATA" | cut -d'|' -f2 | tr -d '[:space:]' | sed 's/^+//')
  LOC=$(echo "$WEATHER_DATA" | cut -d'|' -f3 | cut -d',' -f1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  
  # Format output
  if [ -n "$TEMP" ] && [ -n "$LOC" ]; then
    sketchybar --set "$NAME" label="$TEMP $LOC" icon="${ICON:-󰖐}"
  else
    sketchybar --set "$NAME" label="Offline" icon="󰖐"
  fi
else
  sketchybar --set "$NAME" label="Offline" icon="󰖐"
fi
