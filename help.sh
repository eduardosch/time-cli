#!/usr/bin/env bash

source "$(dirname "$0")/clock_lib.sh"

COMMANDS=(
    "watch.sh    |  Clock        |  Display a live clock showing the current time"
    "stopwatch.sh|  Stopwatch    |  Count up from zero; press [ENTER] to stop"
    "timer.sh    |  Timer        |  Count down from hh:mm; rings alarm when done"
    "help.sh     |  Help         |  Show this help screen with a running clock"
)

print_commands() {
    local col_script=14 col_name=14 col_desc=50
    local sep="  │  "

    printf '  %-*s%s%-*s%s%s\n' \
        "$col_script" "SCRIPT" "$sep" \
        "$col_name"   "NAME"   "$sep" \
        "DESCRIPTION"

    printf '  %s\n' "$(printf '─%.0s' $(seq 1 $(( col_script + ${#sep} + col_name + ${#sep} + col_desc ))))"

    local line script name desc
    for line in "${COMMANDS[@]}"; do
        IFS='|' read -r script name desc <<< "$line"
        printf '  %-*s%s%-*s%s%s\n' \
            "$col_script" "${script// /}" "$sep" \
            "$col_name"   "${name// /}" "$sep" \
            "${desc# }"
    done
}

main() {
    tput civis 2>/dev/null
    trap 'tput cnorm 2>/dev/null; clear' EXIT
    trap 'exit' INT TERM

    clear
    printf '\n  time-cli  -  Press [CTRL+C] to exit\n\n'
    tput sc

    while true; do
        tput rc
        print_big_time "$(date +%H:%M:%S)"
        printf '\n'
        print_commands
        printf '\n  Usage: bash <script> [args]\n'
        printf '  Example: bash timer.sh 0:30\n'

        IFS= read -r -s -t 0.1 -n 1 || true
    done
}

main
