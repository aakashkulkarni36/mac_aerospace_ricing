#!/usr/bin/env bash

TARGET="${NAME:-cpu}"
CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | cut -d% -f1 | cut -d. -f1)
[ -z "$CPU" ] && CPU="0"

sketchybar --set "$TARGET" icon="󰍛" label="CPU ${CPU}%"
