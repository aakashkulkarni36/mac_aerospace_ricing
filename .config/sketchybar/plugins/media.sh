#!/usr/bin/env bash

# Fetch current media title from Spotify or Music if playing
STATE=$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to player state as string' 2>/dev/null)
if [ "$STATE" = "playing" ]; then
  TRACK=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null | cut -c 1-28)
  ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null | cut -c 1-20)
  sketchybar --set "$NAME" drawing=on icon="󰓇" label="$TRACK - $ARTIST"
  exit 0
fi

MUSIC_STATE=$(osascript -e 'if application "Music" is running then tell application "Music" to player state as string' 2>/dev/null)
if [ "$MUSIC_STATE" = "playing" ]; then
  TRACK=$(osascript -e 'tell application "Music" to name of current track' 2>/dev/null | cut -c 1-28)
  sketchybar --set "$NAME" drawing=on icon="" label="$TRACK"
  exit 0
fi

sketchybar --set "$NAME" drawing=off
