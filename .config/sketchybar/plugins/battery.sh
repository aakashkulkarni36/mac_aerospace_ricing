#!/usr/bin/env bash
NAME="${NAME:-battery}"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

[ -z "$PERCENTAGE" ] && exit 0

case ${PERCENTAGE} in
  9[0-9]|100) ICON="󰁹" ;;
  [6-8][0-9]) ICON="󰂂" ;;
  [3-5][0-9]) ICON="󰁾" ;;
  [1-2][0-9]) ICON="󰁼" ;;
  *) ICON="󰁺" ;;
esac

if [ -n "$CHARGING" ]; then
  ICON="󰂄"
  COLOR="0xffa6e3a1" # Green
elif [ "$PERCENTAGE" -le 20 ]; then
  COLOR="0xfff38ba8" # Warning Red
elif [ "$PERCENTAGE" -le 50 ]; then
  COLOR="0xfff9e2af" # Caution Yellow
else
  COLOR="0xffa6e3a1" # Healthy Green
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
