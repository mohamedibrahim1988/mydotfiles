#!/bin/bash

eww="eww"

notify() {
    notify-send --icon=cs-keyboard "$@"
}

set_layout() {
    case "$1" in
    us)
        setxkbmap us,ara -option grp:win_super_toggle
        $eww update us_class="kb_button_active" ar_class="kb_button_inactive"
        notify "Language: English 🇬🇧"
        ;;
    ara)
        setxkbmap ara -variant digits
        $eww update us_class="kb_button_inactive" ar_class="kb_button_active"
        notify "Language: Arabic 🇪🇬"
        ;;
    *)
        echo "Usage: $0 set [us|ara]"
        exit 1
        ;;
    esac
}

if [[ "$1" == "set" && -n "$2" ]]; then
    set_layout "$2"
else
    # Toggle mode (for sxhkd)
    current_layout=$(setxkbmap -query | awk '/layout:/ {print $2}')
    if [[ "$current_layout" == "us" || "$current_layout" == "us,ara" ]]; then
        set_layout "ara"
    else
        set_layout "us"
    fi
fi
