#!/usr/bin/env bash

# RAM Pressure / Usage percentage with explicit label
MEM=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100 - $5}')

sketchybar --set "$NAME" icon="󰘚" label="RAM ${MEM}%"
