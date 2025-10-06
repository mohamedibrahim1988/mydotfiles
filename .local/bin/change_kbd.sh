#!/bin/bash
notify() {
    notify-send --icon=cs-keyboard "$@"
}

layout=$(setxkbmap -query | awk '/layout:/ {print $2}')

if [ "$layout" = "us" ]; then
    setxkbmap -layout ara -variant digits
    kill -45 $(pidof dwmblocks)
    sleep 0.5 && notify "Language Arabic"
elif [ "$layout" = "ara" ]; then
    setxkbmap -layout us
    kill -45 $(pidof dwmblocks)
    sleep 0.5 && notify "Language English"
fi
