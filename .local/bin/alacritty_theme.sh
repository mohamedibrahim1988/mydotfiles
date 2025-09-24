#!/bin/bash

# change theme to Alacritty
# Directory containing theme files
THEMES_DIR="$HOME/.config/alacritty/themes"

# List available themes (without .toml)
themes=$(ls "$THEMES_DIR" | sed 's/\.toml$//')

# Show themes in rofi dmenu
THEME=$(echo "$themes" | rofi -dmenu -p "Alacritty Theme:")

# If user cancelled
[ -z "$THEME" ] && exit 0

# Check if theme file exists
if [ ! -f "$THEMES_DIR/$THEME.toml" ]; then
    notify-send "Alacritty theme switcher" "Theme $THEME.toml not found!"
    exit 1
fi

# Replace import line in alacritty.toml
sed -i \
    -e "s|\"themes/.*\.toml\",|\"themes/${THEME}.toml\",|" \
    "$HOME/.config/alacritty/alacritty.toml"

# Notify result
if [ $? -eq 0 ]; then
    notify-send "Alacritty theme switcher" "Switched to theme: $THEME"
else
    notify-send "Alacritty theme switcher" "Failed to switch theme."
    exit 1
fi
