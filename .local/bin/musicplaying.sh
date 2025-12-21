#!/bin/bash
setxkbmap -layout us,ara -option grp:win_space_toggle
OLDS="/media/mohamed/Movies/Songs/arabic/Olds/"
WARDA="${OLDS}Warda"
FAIROZ="${OLDS}Fairoz"
SHADIA="${OLDS}shadia"

mesg="Choose an artist"
theme="$HOME/.config/rofi/styles/MoviePlay.rasi"
warda="Warda"
fairoz="Fairoz"
shadia="Shadia"
options="old\n$warda\n$fairoz\n$shadia"

rofi_cmd() {
    rofi -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "$1" \
        -mesg "$mesg" \
        -multi-select \
        -theme ${theme}
}

# Step 1: choose artist
chosen_artist="$(echo -e "$options" | rofi_cmd "Artist")" || exit 1

case "$chosen_artist" in
"old")
    music_dir="$OLDS"
    ;;
"$warda")
    music_dir="$WARDA"
    ;;
"$fairoz")
    music_dir="$FAIROZ"
    ;;
"$shadia")
    music_dir="$SHADIA"
    ;;
*)
    exit 1
    ;;
esac

# Step 2: choose files from that directory
#songs="$(find "$music_dir" -type f | sed "s|^$PWD/||" | rofi_cmd "Select Songs")" || exit 1

songs="$(find "$music_dir" -type f | sed "s|.*/Movies/||" | rofi_cmd "Select Songs")" || exit 1
# Step 3: add them to the playlist
while IFS= read -r file; do
    [[ -n "$file" ]] && mpc add "$file"
done <<<"$songs"

setxkbmap -layout us -option grp:win_space_toggle
# Optional: show a notification
notify-send "🎶 Added to queue" "$(echo "$songs" | wc -l) songs added"
mpc play >/dev/null
