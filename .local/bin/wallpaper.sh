#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
export DISPLAY=:0
ls -d /home/mohamed/Pictures/* | shuf | head -n1 | xargs xwallpaper --zoom
