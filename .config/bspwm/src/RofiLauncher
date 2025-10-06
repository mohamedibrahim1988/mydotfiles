#!/bin/bash

# ----Config files-----
cfgStyle="$HOME/.config/rofi/config/.launcher"
CFG_COLOR="$HOME/.config/rofi//config/.color_scheme"
COLOR_THEME="$HOME/.config/rofi/styles/ColorSelect.rasi"
colorDir="$HOME/.config/rofi/colors"

[ -f "$cfgStyle" ] || echo "1" >"$cfgStyle"
[ -f "$CFG_COLOR" ] || echo "default" >"$CFG_COLOR"

# Paths
styleDir="$HOME/.config/rofi/styles"
# Function to select the styles
choose_launcher_style() {

    read -r current_style <"$cfgStyle"

    # Find styles
    styles=$(find "$styleDir" -type f -name 'style_*.rasi' | sed 's|.*/style_\([0-9]*\)\.rasi|\1|' | sort -n)

    # Find current style
    selected_index=-1
    index=0
    IFS='
'
    for style in $styles; do
        if [ "$style" = "$current_style" ]; then
            selected_index=$index
            break
        fi
        index=$((index + 1))
    done
    unset IFS

    # Show the rofi selection menu
    selected=$(
        IFS='
'
        for style in $styles; do
            echo "${styles}"
        done | rofi -dmenu \
            -theme "$HOME/.config/rofi/styles/StyleSelect.rasi" \
            -selected-row "$selected_index"
    )

    # Write the selection to config file
    [ -n "$selected" ] && echo "${selected}" >"$cfgStyle"

}
choose_color() {

    read -r current_color <"$CFG_COLOR"
    # Find available color files
    colors=$(find "$colorDir" -type f -name '*.rasi' |
        sed 's|.*/||;s|\.rasi$||' | sort -n)

    # Determine currently selected index
    selected_index=-1
    index=0
    IFS=$'\n'
    for color in $colors; do
        if [ "$color" = "$current_color" ]; then
            selected_index=$index
            break
        fi
        index=$((index + 1))
    done
    unset IFS

    # Show the rofi selection menu
    selected=$(printf '%s\n' $colors |
        rofi -dmenu \
            -theme "$COLOR_THEME" \
            -mesg "Current Color [$current_color]" \
            -selected-row "$selected_index")

    # Save selection if not empty
    if [ -n "$selected" ]; then
        echo "$selected" >"$CFG_COLOR"
        current_color="$selected" # update variable for later use
    fi
    cp "$colorDir/${current_color}.rasi" "$HOME/.config/rofi/colors/color.rasi"
}

launch_launcher() {
    read -r current_style <"$cfgStyle"
    ROFI_THEME="$HOME/.config/rofi/styles/style_$current_style.rasi"
    rofi -show drun -theme "$ROFI_THEME"
}
# -- Main executor -- #
case "$1" in
--both)
    choose_color
    choose_launcher_style
    ;;
--colors)
    choose_color
    ;;
--styles)
    choose_launcher_style
    ;;
--launcher | *)
    launch_launcher
    ;;
esac
