#!/bin/bash

dwmblocks &
sxhkd -c "$HOME/.config/sxhkd/sxhkdrc" &
picom -b --config "$HOME/.config/picom/picom.conf" &
numlockx on &
mpDris2 &
#setxkbmap -layout us,ara -variant ,digits -option grp:alt_shift_toggle &
xwallpaper --zoom /media/mohamed/Data/walls/ryan-6.png &
