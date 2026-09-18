#!/usr/bin/env bash

BITS=(
  "1 1 1  1 0 1  1 0 1  1 0 1  1 1 1"  # 0
  "0 1 0  0 1 0  0 1 0  0 1 0  0 1 0"  # 1
  "1 1 1  0 0 1  1 1 1  1 0 0  1 1 1"  # 2
  "1 1 1  0 0 1  1 1 1  0 0 1  1 1 1"  # 3
  "1 0 1  1 0 1  1 1 1  0 0 1  0 0 1"  # 4
  "1 1 1  1 0 0  1 1 1  0 0 1  1 1 1"  # 5
  "1 1 1  1 0 0  1 1 1  1 0 1  1 1 1"  # 6
  "1 1 1  0 0 1  0 0 1  0 0 1  0 0 1"  # 7
  "1 1 1  1 0 1  1 1 1  1 0 1  1 1 1"  # 8
  "1 1 1  1 0 1  1 1 1  0 0 1  0 0 1"  # 9
)

ON="██"
OFF="  "

digit_row() {
    local -a bits
    read -ra bits <<< "${BITS[$1]}"
    local off=$(( $2 * 3 ))
    for (( c=0; c<3; c++ )); do
        (( bits[off+c] )) && printf '%s' "$ON" || printf '%s' "$OFF"
    done
}

colon_row() {
    case "$1" in 1|3) printf '%s' "$ON" ;; *) printf '%s' "$OFF" ;; esac
}

print_big_time() {
    local ts="$1"
    local H="${ts:0:1}" h="${ts:1:1}" M="${ts:3:1}" m="${ts:4:1}" S="${ts:6:1}" s="${ts:7:1}"
    local row
    for row in 0 1 2 3 4; do
        printf '  '
        digit_row "$H" "$row"; printf '%s' "$OFF"
        digit_row "$h" "$row"; printf '%s' "$OFF"
        colon_row "$row";      printf '%s' "$OFF"
        digit_row "$M" "$row"; printf '%s' "$OFF"
        digit_row "$m" "$row"; printf '%s' "$OFF"
        colon_row "$row";      printf '%s' "$OFF"
        digit_row "$S" "$row"; printf '%s' "$OFF"
        digit_row "$s" "$row"
        printf '\n'
    done
}
