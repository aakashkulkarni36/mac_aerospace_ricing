#!/usr/bin/env bash

TARGET="${NAME:-ram}"
MEM=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100 - $5}')
[ -z "$MEM" ] && MEM="0"

sketchybar --set "$TARGET" icon="󰘚" label="RAM Used ${MEM}%"
