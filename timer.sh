#!/usr/bin/env bash

source "$(dirname "$0")/clock_lib.sh"

format_time() {
    local secs="$1"
    printf "%02d:%02d:%02d" $((secs/3600)) $(( (secs%3600)/60 )) $((secs%60))
}

usage() {
    cat <<EOF

  timer.sh — Countdown Timer

  Counts down from the given time and rings an alarm when it reaches zero.
  The remaining time is shown as large block digits.

  Usage:
    bash timer.sh hh:mm

  Arguments:
    hh:mm     Hours and minutes to count down from (e.g. 0:30 for 30 minutes)

  Controls:
    CTRL+C    Stop the timer early

  Examples:
    bash timer.sh 0:30    # 30-minute timer
    bash timer.sh 1:00    # 1-hour timer

EOF
}

main() {
    local input="$1"

    [[ "$input" == "-h" || "$input" == "--help" ]] && { usage; exit 0; }

    if [[ -z "$input" || ! "$input" =~ ^[0-9]{1,2}:[0-9]{2}$ ]]; then
        printf 'Usage: %s hh:mm\n' "$(basename "$0")" >&2
        exit 1
    fi

    local hh="${input%%:*}" mm="${input##*:}"
    local total=$(( 10#$hh * 3600 + 10#$mm * 60 ))

    if (( total == 0 )); then
        printf 'Error: time must be greater than 00:00\n' >&2
        exit 1
    fi

    local start remaining
    start=$(date +%s)

    tput civis 2>/dev/null
    trap 'tput cnorm 2>/dev/null' EXIT
    trap 'exit' INT TERM

    clear
    printf '\n  Timer  -  Press [CTRL+C] to stop\n\n'
    tput sc

    while true; do
        remaining=$(( total - ($(date +%s) - start) ))
        (( remaining < 0 )) && remaining=0

        tput rc
        print_big_time "$(format_time $remaining)"

        (( remaining == 0 )) && break

        IFS= read -r -s -t 0.1 -n 1 || true
    done

    tput cnorm 2>/dev/null
    printf '\a'
    clear
    printf '\n  Time'\''s up!\n\n'
    print_big_time "$(format_time 0)"
    printf '\n'
}

main "$@"
