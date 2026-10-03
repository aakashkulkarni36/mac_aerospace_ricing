#!/usr/bin/env bash

case "$SENDER" in
  mouse.entered|mouse.exited|mouse.clicked)
    exec "$HOME/.config/sketchybar/plugins/hardware_hover.sh"
    ;;
esac

# Fast CPU Calculation (~10ms)
CORES=$(sysctl -n hw.logicalcpu 2>/dev/null || echo 8)
CPU=$(ps -A -o %cpu | awk -v cores="$CORES" '{s+=$1} END {printf "%.0f", s/cores}')
[ -z "$CPU" ] && CPU="0"

CPU_GRAPH_VAL=$(awk -v c="$CPU" 'BEGIN {printf "%.2f", c/100}')
[ $(awk -v v="$CPU_GRAPH_VAL" 'BEGIN {print (v > 1.0)}') -eq 1 ] && CPU_GRAPH_VAL="1.00"

# Fast RAM Calculation via sysctl + vm_stat (~4ms)
TOTAL_MEM_BYTES=$(sysctl -n hw.memsize 2>/dev/null || echo 17179869184)
TOTAL_GB=$(awk -v b="$TOTAL_MEM_BYTES" 'BEGIN {printf "%.0f", b/1073741824}')

PAGES_ACTIVE=$(vm_stat 2>/dev/null | awk '/Pages active:/ {gsub("\\.",""); print $3}')
PAGES_WIRED=$(vm_stat 2>/dev/null | awk '/Pages wired down:/ {gsub("\\.",""); print $4}')
PAGES_COMP=$(vm_stat 2>/dev/null | awk '/Pages occupied by compressor:/ {gsub("\\.",""); print $5}')

[ -z "$PAGES_ACTIVE" ] && PAGES_ACTIVE=0
[ -z "$PAGES_WIRED" ] && PAGES_WIRED=0
[ -z "$PAGES_COMP" ] && PAGES_COMP=0

PAGE_SIZE=16384 # 16KB Apple Silicon page size
USED_BYTES=$(( (PAGES_ACTIVE + PAGES_WIRED + PAGES_COMP) * PAGE_SIZE ))
USED_GB=$(awk -v u="$USED_BYTES" 'BEGIN {printf "%.1f", u/1073741824}')
MEM=$(awk -v u="$USED_BYTES" -v t="$TOTAL_MEM_BYTES" 'BEGIN {printf "%.0f", (u/t)*100}')
[ -z "$MEM" ] && MEM="0"

RAM_GRAPH_VAL=$(awk -v m="$MEM" 'BEGIN {printf "%.2f", m/100}')
[ $(awk -v v="$RAM_GRAPH_VAL" 'BEGIN {print (v > 1.0)}') -eq 1 ] && RAM_GRAPH_VAL="1.00"

# Push to rolling graphs inside popup
sketchybar --push hw.popup.cpu_graph "$CPU_GRAPH_VAL" 2>/dev/null || true
sketchybar --push hw.popup.ram_graph "$RAM_GRAPH_VAL" 2>/dev/null || true

# Update Bar Pills
sketchybar --set cpu label="CPU ${CPU}%" 2>/dev/null || true
sketchybar --set ram label="RAM ${MEM}%" 2>/dev/null || true
sketchybar --set hw.popup.hdr_cpu label="CPU Load: ${CPU}% · ${CORES} Cores" 2>/dev/null || true
sketchybar --set hw.popup.hdr_mem label="Memory: ${MEM}% · ${USED_GB} GB / ${TOTAL_GB} GB" 2>/dev/null || true

# Gather Top 3 CPU Processes
clean_name() {
  echo "$1" | sed -E 's/com\.apple\.WebKit\.WebContent/Safari WebContent/; s/com\.google\.Chrome\.helper/Chrome Helper/'
}

TOP_CPU_ITEMS=()
while IFS= read -r line; do
  [ -n "$line" ] && TOP_CPU_ITEMS+=("$line")
done < <(ps -Ao %cpu,comm -r 2>/dev/null | sed -n '2,4p' | awk '{n=split($2,a,"/"); printf "%s  ·  %s%%\n", a[n], $1}')

P1=$(clean_name "${TOP_CPU_ITEMS[0]:-None}")
P2=$(clean_name "${TOP_CPU_ITEMS[1]:-None}")
P3=$(clean_name "${TOP_CPU_ITEMS[2]:-None}")

[ ${#P1} -gt 28 ] && P1="${P1:0:26}…"
[ ${#P2} -gt 28 ] && P2="${P2:0:26}…"
[ ${#P3} -gt 28 ] && P3="${P3:0:26}…"

sketchybar --set hw.top_cpu1 label="•  $P1" 2>/dev/null \
           --set hw.top_cpu2 label="•  $P2" 2>/dev/null \
           --set hw.top_cpu3 label="•  $P3" 2>/dev/null

# Gather Top 3 RAM Processes
TOP_MEM_ITEMS=()
while IFS= read -r line; do
  [ -n "$line" ] && TOP_MEM_ITEMS+=("$line")
done < <(ps -Ao %mem,comm -m 2>/dev/null | sed -n '2,4p' | awk '{n=split($2,a,"/"); printf "%s  ·  %s%%\n", a[n], $1}')

M1=$(clean_name "${TOP_MEM_ITEMS[0]:-None}")
M2=$(clean_name "${TOP_MEM_ITEMS[1]:-None}")
M3=$(clean_name "${TOP_MEM_ITEMS[2]:-None}")

[ ${#M1} -gt 28 ] && M1="${M1:0:26}…"
[ ${#M2} -gt 28 ] && M2="${M2:0:26}…"
[ ${#M3} -gt 28 ] && M3="${M3:0:26}…"

sketchybar --set hw.top_mem1 label="•  $M1" 2>/dev/null \
           --set hw.top_mem2 label="•  $M2" 2>/dev/null \
           --set hw.top_mem3 label="•  $M3" 2>/dev/null
