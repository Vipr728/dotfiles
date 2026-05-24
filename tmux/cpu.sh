#!/usr/bin/env bash

cache="${TMPDIR:-/tmp}/tmux-cpu-${UID:-$(id -u)}"
now="$(date +%s)"

if [[ -r "$cache" ]]; then
    ts="$(sed -n '1p' "$cache")"
    val="$(sed -n '2p' "$cache")"
    if [[ "$ts" =~ ^[0-9]+$ && -n "$val" && $((now - ts)) -lt 25 ]]; then
        printf "%s" "$val"
        exit 0
    fi
fi

case "$(uname -s 2>/dev/null)" in
    Darwin)
        val="$(top -l 2 -n 0 | awk '/CPU usage/ { line=$0 } END { split(line, a, " "); gsub("%", "", a[3]); gsub("%", "", a[5]); printf "%.0f%%", a[3] + a[5] }')"
        ;;
    Linux)
        read -r _ u n s i w irq sirq steal _ < /proc/stat
        idle1=$((i + w))
        total1=$((u + n + s + i + w + irq + sirq + steal))
        sleep 0.2
        read -r _ u n s i w irq sirq steal _ < /proc/stat
        idle2=$((i + w))
        total2=$((u + n + s + i + w + irq + sirq + steal))
        diff_idle=$((idle2 - idle1))
        diff_total=$((total2 - total1))
        if (( diff_total > 0 )); then
            val="$(awk -v idle="$diff_idle" -v total="$diff_total" 'BEGIN { printf "%.0f%%", (1 - idle / total) * 100 }')"
        fi
        ;;
    MINGW*|MSYS*|CYGWIN*)
        val="$(wmic cpu get loadpercentage 2>/dev/null | awk 'NR==2 { printf "%s%%", $1 }')"
        ;;
esac
[[ -n "$val" ]] || val="?"
printf "%s\n%s\n" "$now" "$val" > "$cache"
printf "%s" "$val"
