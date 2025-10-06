#!/bin/bash

# ── configuration ────────────────────────────────
TEMPS=("off" "6500" "5300" "4500" "3500") # add/remove as you like
STATE_FILE="/tmp/redshift_state"
ROFI_CMD="rofi -dmenu -p 'Redshift Temp' -i -theme /home/mohamed/.config/bspwm/src/keyboardhelp.rasi"

# ── helpers ──────────────────────────────────────
apply_temp() {
    local temp=$1
    if [[ "$temp" == "off" ]]; then
        redshift -m randr -x &
    else
        redshift -m randr -P -O "$temp" &
    fi
    echo "$temp" >"$STATE_FILE"
}

# ── main ─────────────────────────────────────────
# current state
CURRENT="off"
[[ -f "$STATE_FILE" ]] && CURRENT=$(<"$STATE_FILE")

# build menu list with current marked
MENU=""
for t in "${TEMPS[@]}"; do
    if [[ "$t" == "$CURRENT" ]]; then
        MENU+="$t (current)\n"
    else
        MENU+="$t\n"
    fi
done

# ask user via rofi
SELECTED=$(echo -e "$MENU" | $ROFI_CMD | sed 's/ (current)//')

# if nothing chosen, exit
[[ -z "$SELECTED" ]] && exit 0

# apply selection
apply_temp "$SELECTED"
