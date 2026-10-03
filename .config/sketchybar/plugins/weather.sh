#!/usr/bin/env bash

TARGET_NAME="${NAME:-weather}"

# Handle interactive hover events
case "$SENDER" in
  "mouse.entered")
    sketchybar --set "$TARGET_NAME" popup.drawing=on 2>/dev/null
    exit 0
    ;;
  "mouse.exited")
    sketchybar --set "$TARGET_NAME" popup.drawing=off 2>/dev/null
    exit 0
    ;;
  "mouse.clicked")
    sketchybar --set "$TARGET_NAME" popup.drawing=off 2>/dev/null
    open "x-apple.weather:"
    exit 0
    ;;
esac

CACHE_FILE="/tmp/sketchybar_weather.json"
CACHE_AGE=600 # 10 minutes

# Only fetch if cache does not exist or is older than CACHE_AGE
if [ ! -f "$CACHE_FILE" ] || [ $(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0))) -gt $CACHE_AGE ]; then
  curl -s -m 3 "https://wttr.in/McKinney?format=j1" > "$CACHE_FILE.tmp" 2>/dev/null
  if [ -s "$CACHE_FILE.tmp" ] && jq -e '.current_condition[0]' "$CACHE_FILE.tmp" >/dev/null 2>&1; then
    mv "$CACHE_FILE.tmp" "$CACHE_FILE"
  else
    rm -f "$CACHE_FILE.tmp"
  fi
fi

if [ -f "$CACHE_FILE" ]; then
  COND_CODE=$(jq -r '.current_condition[0].weatherCode // empty' "$CACHE_FILE")
  TEMP_C=$(jq -r '.current_condition[0].temp_C // empty' "$CACHE_FILE")
  TEMP_F=$(jq -r '.current_condition[0].temp_F // empty' "$CACHE_FILE")
  FEELS_C=$(jq -r '.current_condition[0].FeelsLikeC // empty' "$CACHE_FILE")
  FEELS_F=$(jq -r '.current_condition[0].FeelsLikeF // empty' "$CACHE_FILE")
  DESC=$(jq -r '.current_condition[0].weatherDesc[0].value // empty' "$CACHE_FILE")
  HUMID=$(jq -r '.current_condition[0].humidity // empty' "$CACHE_FILE")
  PRECIP=$(jq -r '.current_condition[0].precipMM // empty' "$CACHE_FILE")
  WIND_SPD=$(jq -r '.current_condition[0].windspeedKmph // empty' "$CACHE_FILE")
  WIND_DIR=$(jq -r '.current_condition[0].winddir16Point // empty' "$CACHE_FILE")
  PRESSURE=$(jq -r '.current_condition[0].pressure // empty' "$CACHE_FILE")
  CLOUD=$(jq -r '.current_condition[0].cloudcover // empty' "$CACHE_FILE")
  MAX_C=$(jq -r '.weather[0].maxtempC // empty' "$CACHE_FILE")
  MIN_C=$(jq -r '.weather[0].mintempC // empty' "$CACHE_FILE")
  LOC="McKinney"

  # Map weather condition codes to vibrant Nerd Font icons and colors
  case "$COND_CODE" in
    113) # Sunny / Clear
      ICON="󰖙"
      ICON_COLOR="0xfff9e2af" # Warm Yellow
      ;;
    116) # Partly Cloudy
      ICON="󰖕"
      ICON_COLOR="0xff89dceb" # Sky Blue
      ;;
    119|122) # Cloudy / Overcast
      ICON="󰖐"
      ICON_COLOR="0xffa6adc8" # Slate
      ;;
    176|263|266|281|284|293|296|299|302|305|308|311|314|353|356|359) # Rain / Drizzle / Showers
      ICON="󰖖"
      ICON_COLOR="0xff38bdf8" # Vivid Rain Blue
      ;;
    200|386|389|392|395) # Thunderstorm
      ICON="󰖓"
      ICON_COLOR="0xffcba6f7" # Mauve / Electric
      ;;
    179|182|227|230|323|326|329|332|335|338|350|368|371|374|377) # Snow
      ICON="󰖘"
      ICON_COLOR="0xffb4befe" # Lavender
      ;;
    143|248|260) # Fog / Mist
      ICON="󰖑"
      ICON_COLOR="0xff94e2d5" # Teal
      ;;
    *)
      ICON="󰖐"
      ICON_COLOR="0xff38bdf8"
      ;;
  esac

  [ -z "$TEMP_C" ] && TEMP_C="21"
  [ -z "$TEMP_F" ] && TEMP_F="70"
  [ -z "$FEELS_C" ] && FEELS_C="$TEMP_C"
  [ -z "$PRECIP" ] && PRECIP="0.0"
  [ -z "$CLOUD" ] && CLOUD="0"
  [ -z "$MAX_C" ] && MAX_C="26"
  [ -z "$MIN_C" ] && MIN_C="19"

  LABEL="${TEMP_C}°C ${LOC}"

  sketchybar \
    --set "$TARGET_NAME" icon="$ICON" icon.color="$ICON_COLOR" label="$LABEL" 2>/dev/null \
    --set weather.card.loc label="${LOC}, Texas" 2>/dev/null \
    --set weather.card.hero icon="$ICON" icon.color="$ICON_COLOR" label="${TEMP_C}°C  ·  ${TEMP_F}°F" 2>/dev/null \
    --set weather.card.condition label="${DESC}  ·  Feels like ${FEELS_C}°C" 2>/dev/null \
    --set weather.card.range label="H: ${MAX_C}°C  L: ${MIN_C}°C  ·  Precip: ${PRECIP} mm" 2>/dev/null \
    --set weather.card.stats label="Humidity: ${HUMID}%  ·  Cloud: ${CLOUD}%" 2>/dev/null \
    --set weather.card.wind label="Wind: ${WIND_SPD} km/h ${WIND_DIR}  ·  ${PRESSURE} hPa" 2>/dev/null
else
  sketchybar --set "$TARGET_NAME" icon="󰖐" icon.color="0xff38bdf8" label="21°C McKinney" 2>/dev/null
fi
