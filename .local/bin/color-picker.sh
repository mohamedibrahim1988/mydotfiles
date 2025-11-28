#!/bin/sh

COLOR_SCRIPT="$HOME/.local/bin/color-convert.sh" # adjust if needed

# Conversion options
option1="Number to HEX/RGB"
option2="HEX to Number"

# 1. Choose conversion action
option=$(
    printf "%s\n" "$option1" "$option2" |
        dmenu -i -p "Choose conversion"
)

[ -z "$option" ] && exit

# Map the chosen option to the actual script flag
case "$option" in
"$option1") flag="-n" ;;
"$option2") flag="-x" ;;
*)
    notify-send "Error" "Unknown option"
    exit
    ;;
esac

# 2. Ask for input based on the option
case "$flag" in
-n)
    input=$(printf "" | dmenu -p "Enter number (0–255)")
    ;;
-x)
    input=$(printf "" | dmenu -p "Enter hex (#RRGGBB)")
    ;;
esac

[ -z "$input" ] && exit

# 3. Run your actual script
output=$("$COLOR_SCRIPT" "$flag" "$input")

# 4. Show result with dmenu AND notify + copy selected field to clipboard
chosen=$(printf "%s\n" "$output" | dmenu -l 10 -p "Result")

# Only copy if user selected something
[ -n "$chosen" ] && printf "%s" "$chosen" | awk '{printf $2}' | xclip -selection clipboard

# Notify full output
notify-send "Color Conversion" "$output"
