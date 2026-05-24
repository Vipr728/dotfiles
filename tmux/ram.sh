#!/usr/bin/env bash

cache="${TMPDIR:-/tmp}/tmux-ram-${UID:-$(id -u)}"
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
        val="$(top -l 1 -n 0 | awk '/PhysMem/ {
            used = $2
            if (sub(/G/, "", used)) printf "%.1fG", used + 0
            else if (sub(/M/, "", used)) printf "%.1fG", used / 1024
            else print used
        }')"
        ;;
    Linux)
        val="$(awk '
            /^MemTotal:/ { total=$2 }
            /^MemAvailable:/ { available=$2 }
            END {
                if (total > 0 && available > 0) printf "%.1fG", (total - available) / 1024 / 1024
            }
        ' /proc/meminfo)"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        val="$(wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value 2>/dev/null | awk -F= '
            /FreePhysicalMemory/ { free=$2 }
            /TotalVisibleMemorySize/ { total=$2 }
            END {
                if (total > 0) printf "%.1fG", (total - free) / 1024 / 1024
            }
        ')"
        ;;
esac
[[ -n "$val" ]] || val="?"
printf "%s\n%s\n" "$now" "$val" > "$cache"
printf "%s" "$val"
