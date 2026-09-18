#!/usr/bin/env bash

source "$(dirname "$0")/clock_lib.sh"

main() {
    tput civis 2>/dev/null
    trap 'tput cnorm 2>/dev/null; clear' EXIT
    trap 'exit' INT TERM

    clear
    printf '\n  Current time  -  Press [CTRL+C] to exit\n\n'
    tput sc

    while true; do
        tput rc
        print_big_time "$(date +%H:%M:%S)"

        if IFS= read -r -s -t 0.1 -n 1; then :; fi
    done
}

main
