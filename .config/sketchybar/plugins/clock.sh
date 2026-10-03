#!/usr/bin/env bash

TARGET="${NAME:-clock}"
sketchybar --set "$TARGET" label="$(date '+%a %b %d  %I:%M:%S %p')"
