#!/bin/bash
notify() {
    notify-send --icon=cs-keyboard "$@"
}

layout=$(setxkbmap -query | awk '/layout:/ {print $2}')

if [ "$layout" == "us,ara" ] || [ "$layout" == "us" ]; then
    setxkbmap -layout ara -variant digits,
    kill -45 $(pidof dwmblocks)
    sleep 0.5 && notify "Language Arabic"
elif [ "$layout" = "ara" ]; then
    setxkbmap -layout us,ara -option grp:win_space_toggle
    kill -45 $(pidof dwmblocks)
    sleep 0.5 && notify "Language English"
fi
