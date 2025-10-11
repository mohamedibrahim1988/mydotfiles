#!/bin/bash

run() {
    if ! pidof -q "$1"; then
        "$@" &
    fi
}
run mpDris2
run eww -c ~/.config/eww daemon
bspc config -m HDMI-0 top_padding 34
eww -c $HOME/.config/eww --restart open bar &
run sxhkd -c ~/.config/bspwm/src/config/sxhkdrc
run picom -b --config "${HOME}"/.config/bspwm/src/config/picom.conf
## Launch xsettingsd
run xsettingsd --config="${HOME}"/.config/bspwm/src/config/xsettingsd >/dev/null 2>&1
xsetroot -cursor_name left_ptr &
numlockx on &
xwallpaper --zoom ~/.local/share/bg &
