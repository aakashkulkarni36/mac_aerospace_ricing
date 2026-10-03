#!/usr/bin/env bash

TARGET="${NAME:-ram}"

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

# 1. Fast RAM calculation (sysctl + vm_stat, ~4ms)
TOTAL_MEM_BYTES=$(sysctl -n hw.memsize 2>/dev/null || echo 17179869184)
TOTAL_GB=$(awk -v b="$TOTAL_MEM_BYTES" 'BEGIN {printf "%.0f", b/1073741824}')

# Parse vm_stat for accurate active footprint
PAGES_FREE=$(vm_stat 2>/dev/null | awk '/Pages free:/ {gsub("\\.",""); print $3}')
PAGES_SPEC=$(vm_stat 2>/dev/null | awk '/Pages speculative:/ {gsub("\\.",""); print $3}')
PAGES_ACTIVE=$(vm_stat 2>/dev/null | awk '/Pages active:/ {gsub("\\.",""); print $3}')
PAGES_WIRED=$(vm_stat 2>/dev/null | awk '/Pages wired down:/ {gsub("\\.",""); print $4}')
PAGES_COMP=$(vm_stat 2>/dev/null | awk '/Pages occupied by compressor:/ {gsub("\\.",""); print $5}')

[ -z "$PAGES_FREE" ] && PAGES_FREE=0
[ -z "$PAGES_SPEC" ] && PAGES_SPEC=0
[ -z "$PAGES_ACTIVE" ] && PAGES_ACTIVE=0
[ -z "$PAGES_WIRED" ] && PAGES_WIRED=0
[ -z "$PAGES_COMP" ] && PAGES_COMP=0

PAGE_SIZE=16384 # 16KB on Apple Silicon
USED_BYTES=$(( (PAGES_ACTIVE + PAGES_WIRED + PAGES_COMP) * PAGE_SIZE ))
USED_GB=$(awk -v u="$USED_BYTES" 'BEGIN {printf "%.1f", u/1073741824}')
MEM=$(awk -v u="$USED_BYTES" -v t="$TOTAL_MEM_BYTES" 'BEGIN {printf "%.0f", (u/t)*100}')
[ -z "$MEM" ] && MEM="0"

# Convert to 0.0 - 1.0 for sketchybar graph component
GRAPH_VAL=$(awk -v m="$MEM" 'BEGIN {printf "%.2f", m/100}')
[ $(awk -v v="$GRAPH_VAL" 'BEGIN {print (v > 1.0)}') -eq 1 ] && GRAPH_VAL="1.00"

sketchybar --push ram.popup.graph "$GRAPH_VAL" 2>/dev/null || true
sketchybar --set "$TARGET" label="RAM ${MEM}%" \
           --set cpu.popup.hdr_mem label="Memory: ${MEM}% · ${USED_GB} GB / ${TOTAL_GB} GB"

# 2. Gather Top 3 RAM processes formatted cleanly
TOP_MEM_ITEMS=()
while IFS= read -r line; do
  [ -n "$line" ] && TOP_MEM_ITEMS+=("$line")
done < <(ps -Ao %mem,comm -m 2>/dev/null | sed -n '2,4p' | awk '{n=split($2,a,"/"); printf "%s  ·  %s%%\n", a[n], $1}')

M1="${TOP_MEM_ITEMS[0]:-None}"
M2="${TOP_MEM_ITEMS[1]:-None}"
M3="${TOP_MEM_ITEMS[2]:-None}"

clean_name() {
  echo "$1" | sed -E 's/com\.apple\.WebKit\.WebContent/Safari WebContent/; s/com\.google\.Chrome\.helper/Chrome Helper/'
}
M1=$(clean_name "$M1")
M2=$(clean_name "$M2")
M3=$(clean_name "$M3")

[ ${#M1} -gt 28 ] && M1="${M1:0:26}…"
[ ${#M2} -gt 28 ] && M2="${M2:0:26}…"
[ ${#M3} -gt 28 ] && M3="${M3:0:26}…"

sketchybar --set ram.top1 label="•  $M1" \
           --set ram.top2 label="•  $M2" \
           --set ram.top3 label="•  $M3"
