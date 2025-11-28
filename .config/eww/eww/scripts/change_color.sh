#!/bin/bash

CFG_COLOR="$HOME/.config/eww/colors/.current"
COLOR_THEME="$HOME/.config/rofi/styles/ColorSelect.rasi"
COLOR_F="$HOME/.config/eww/colors.scss"
colorDir="$HOME/.config/eww/colors"
[ -f "$CFG_COLOR" ] || echo "onedark" >"$CFG_COLOR"

choose_color() {
    read -r current_color <"$CFG_COLOR"

    # Find the available color options
    colors=$(find "$colorDir" -type f -name '*.scss' |
        sed 's|.*/||;s|\.scss$||' | sort -n)

    selected_index=-1
    index=0
    IFS=$'\n'

    # Set the selected index based on the current color
    for color in $colors; do
        if [ "$color" = "$current_color" ]; then
            selected_index=$index
            break
        fi
        index=$((index + 1))
    done
    unset IFS

    # Show the color selection menu
    selected=$(printf '%s\n' "$colors" |
        rofi -dmenu \
            -theme "$COLOR_THEME" \
            -mesg "Current Color [$current_color]" \
            -selected-row "$selected_index")

    if [ -n "$selected" ]; then
        # Update color.scss with the selected color
        sed -i "s|@import \"./colors/$current_color.scss\"|@import \"./colors/$selected.scss\"|g" "$COLOR_F"

        # Update the current color file
        echo "$selected" >"$CFG_COLOR"
    fi
}

choose_color
