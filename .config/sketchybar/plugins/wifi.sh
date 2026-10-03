#!/usr/bin/env bash

TARGET="${NAME:-wifi}"
# Fast SSID retrieval
SSID=$(ipconfig getsummary en0 2>/dev/null | grep '  SSID : ' | awk -F': ' '{print $2}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Check if SSID is blank, empty, unknown, or macOS privacy redacted
if [ -z "$SSID" ] || [ "$SSID" = "<redacted>" ] || [ "$SSID" = "null" ]; then
  ROUTE=$(route get default 2>/dev/null | grep 'interface:' | awk '{print $2}')
  if [ -n "$ROUTE" ]; then
    sketchybar --set "$TARGET" icon="󰤨" icon.color="0xff06b6d4" label="Connected"
  else
    sketchybar --set "$TARGET" icon="󰤭" icon.color="0xfff38ba8" label="Disconnected"
  fi
else
  [ ${#SSID} -gt 13 ] && SSID="${SSID:0:11}…"
  sketchybar --set "$TARGET" icon="󰤨" icon.color="0xff06b6d4" label="$SSID"
fi
