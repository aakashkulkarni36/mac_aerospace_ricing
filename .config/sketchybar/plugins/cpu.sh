#!/usr/bin/env bash

# CPU Usage percentage with explicit label
CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | cut -d% -f1 | cut -d. -f1)

sketchybar --set "$NAME" icon="󰍛" label="CPU ${CPU}%"
