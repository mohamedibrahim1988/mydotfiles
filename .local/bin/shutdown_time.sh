#!/usr/bin/bash

# Prompt for time in minutes using dmenu
TIME=$(echo -e "1\n2\n3\n5\n10\n15\n30\n60" | dmenu -i -p "Select shutdown timer (in minutes):")

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

