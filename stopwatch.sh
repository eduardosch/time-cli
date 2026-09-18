#!/usr/bin/env bash

source "$(dirname "$0")/clock_lib.sh"

format_time() {
    local secs="$1"
    printf "%02d:%02d:%02d" $((secs/3600)) $(( (secs%3600)/60 )) $((secs%60))
}

usage() {
    cat <<EOF

  stopwatch.sh — Stopwatch

  Counts up from zero using large block digits. The elapsed time is
  displayed and keeps running until you press ENTER.

  Usage:
    bash stopwatch.sh

  Controls:
    ENTER     Stop and display the final time
    CTRL+C    Exit immediately

EOF
}

main() {
    [[ "$1" == "-h" || "$1" == "--help" ]] && { usage; exit 0; }
    local start elapsed time_str key
    start=$(date +%s)

    tput civis 2>/dev/null
    trap 'tput cnorm 2>/dev/null' EXIT
    trap 'exit' INT TERM

    clear
    printf '\n  Stopwatch  -  Press [ENTER] to stop\n\n'
    tput sc

    while true; do
        elapsed=$(( $(date +%s) - start ))
        time_str=$(format_time "$elapsed")

        tput rc
        print_big_time "$time_str"

        if IFS= read -r -s -t 0.1 -n 1 key; then
            [[ -z "$key" ]] && break
        fi
    done

    elapsed=$(( $(date +%s) - start ))
    time_str=$(format_time "$elapsed")

    tput cnorm 2>/dev/null
    clear
    printf '\n  Stopped!  Final time:\n\n'
    print_big_time "$time_str"
    printf '\n'
}

main "$@"
