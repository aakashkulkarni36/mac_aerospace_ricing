#!/usr/bin/env bash

# Clean Connected Wi-Fi indicator
ROUTE=$(route get default 2>/dev/null | grep 'interface:' | awk '{print $2}')

if [ -n "$ROUTE" ]; then
  sketchybar --set "$NAME" icon="󰤨" label="Connected"
else
  sketchybar --set "$NAME" icon="󰤭" label="Offline"
fi
