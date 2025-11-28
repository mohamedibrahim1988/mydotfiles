#!/usr/bin/bash

# Prompt for time in minutes using dmenu
TIME=$(echo -e "10\n20\n30\n45\n50\n60\n100\n110" | dmenu -i -p "Select shutdown timer (in minutes):")

# Check if a valid time was selected
if [ -n "$TIME" ]; then
    # Convert minutes to seconds
    SECONDS=$((TIME * 60))
    # Schedule shutdown
    pkexec /sbin/shutdown -P +"$TIME"
    notify-send "Shutdown scheduled" "The system will shut down in $TIME minutes."
else
    notify-send "No time selected" "Shutdown timer was not set."
fi
