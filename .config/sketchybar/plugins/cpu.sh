#!/usr/bin/env bash

TARGET="${NAME:-cpu}"

case "$SENDER" in
  "mouse.entered")
    sketchybar --set cpu popup.drawing=on
    exit 0
    ;;
  "mouse.exited")
    sketchybar --set cpu popup.drawing=off
    exit 0
    ;;
  "mouse.clicked")
    sketchybar --set cpu popup.drawing=off
    open -a 'Activity Monitor'
    exit 0
    ;;
esac

# 1. Fast CPU load calculation
CORES=$(sysctl -n hw.logicalcpu 2>/dev/null || echo 8)
CPU=$(ps -A -o %cpu | awk -v cores="$CORES" '{s+=$1} END {printf "%.0f", s/cores}')
[ -z "$CPU" ] && CPU="0"

# Convert to 0.0 - 1.0 for sketchybar graph component
GRAPH_VAL=$(awk -v c="$CPU" 'BEGIN {printf "%.2f", c/100}')
[ $(awk -v v="$GRAPH_VAL" 'BEGIN {print (v > 1.0)}') -eq 1 ] && GRAPH_VAL="1.00"

# Push to popup rolling graph (background graph history) and update bar label
sketchybar --push cpu.popup.graph "$GRAPH_VAL" 2>/dev/null || true
sketchybar --set "$TARGET" label="CPU ${CPU}%" \
           --set cpu.popup.hdr_cpu label="CPU Load: ${CPU}% · ${CORES} Cores"

# 2. Gather Top 3 CPU processes formatted cleanly
TOP_CPU_ITEMS=()
while IFS= read -r line; do
  [ -n "$line" ] && TOP_CPU_ITEMS+=("$line")
done < <(ps -Ao %cpu,comm -r 2>/dev/null | sed -n '2,4p' | awk '{n=split($2,a,"/"); printf "%s  ·  %s%%\n", a[n], $1}')

P1="${TOP_CPU_ITEMS[0]:-None}"
P2="${TOP_CPU_ITEMS[1]:-None}"
P3="${TOP_CPU_ITEMS[2]:-None}"

# Clean up common long process names
clean_name() {
  echo "$1" | sed -E 's/com\.apple\.WebKit\.WebContent/Safari WebContent/; s/com\.google\.Chrome\.helper/Chrome Helper/'
}
P1=$(clean_name "$P1")
P2=$(clean_name "$P2")
P3=$(clean_name "$P3")

[ ${#P1} -gt 28 ] && P1="${P1:0:26}…"
[ ${#P2} -gt 28 ] && P2="${P2:0:26}…"
[ ${#P3} -gt 28 ] && P3="${P3:0:26}…"

sketchybar --set cpu.top1 label="•  $P1" \
           --set cpu.top2 label="•  $P2" \
           --set cpu.top3 label="•  $P3"
