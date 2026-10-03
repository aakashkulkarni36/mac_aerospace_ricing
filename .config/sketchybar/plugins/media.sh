#!/usr/bin/env bash

# Universal macOS media indicator using nowplaying-cli
RAW_JSON=$(nowplaying-cli get --json title artist playbackRate 2>/dev/null)

TITLE=$(echo "$RAW_JSON" | jq -r '.title // empty' 2>/dev/null)
RATE=$(echo "$RAW_JSON" | jq -r '.playbackRate // 0' 2>/dev/null)

if [ -z "$TITLE" ] || [ "$TITLE" = "null" ]; then
  # No active playback: cleanly hide media controls so pill only shows Volume
  sketchybar --set media.sep drawing=off \
             --set media.prev drawing=off \
             --set media.play drawing=off \
             --set media.next drawing=off \
             --set media.art drawing=off
  exit 0
fi

# Icon: pause icon when playing, play icon when paused
if [ "$RATE" = "1" ] || [ "$RATE" = "1.0" ]; then
  PLAY_ICON="󰏤"
else
  PLAY_ICON="󰐊"
fi

# Try caching album art if Spotify is playing
CACHE_ART="/tmp/sketchybar_cover.jpg"
TRACK_ID_FILE="/tmp/sketchybar_current_track.txt"
LAST_TRACK=$(cat "$TRACK_ID_FILE" 2>/dev/null)

if [ "$TITLE" != "$LAST_TRACK" ]; then
  echo "$TITLE" > "$TRACK_ID_FILE"
  ART_URL=$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to artwork url of current track' 2>/dev/null)
  if [ -n "$ART_URL" ] && [[ "$ART_URL" == http* ]]; then
    curl -s --max-time 2 "$ART_URL" -o "$CACHE_ART" 2>/dev/null
  else
    rm -f "$CACHE_ART" 2>/dev/null
  fi
fi

# Configure artwork or music glyph on the right of the pill
if [ -f "$CACHE_ART" ]; then
  sketchybar --set media.art \
    background.image="$CACHE_ART" \
    background.image.scale=0.075 \
    background.drawing=on \
    icon.drawing=off
else
  sketchybar --set media.art \
    background.drawing=off \
    icon="󰝚" \
    icon.drawing=on
fi

# Reveal media controls inside the volume & media pill (No Text)
sketchybar --set media.sep drawing=on \
           --set media.prev drawing=on \
           --set media.play drawing=on icon="$PLAY_ICON" \
           --set media.next drawing=on \
           --set media.art drawing=on
