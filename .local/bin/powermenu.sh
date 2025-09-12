#!/usr/bin/bash

logout='󰗽 Logout'
reboot=' Reboot'
shutdown='⏻ Shutdown'
yes=" YES"
no=" NO!"
confirm_exit() {
  echo -e "$yes\n$no" | dmenu -i -p "Confirmation" -l 3 
}
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
      systemctl reboot
    elif [[ $1 == '--logout' ]]; then
      loginctl terminate-session "$XDG_SESSION_ID"
    fi
  else
    exit 0
  fi
}
dmenu_cmd() {
  dmenu -i \
    -p "Good bye!" \
    -l 5 \
    -fn "JetBrainsMono Nerd Font Mono:style=Bold:size=15"
}
run_dmenu() {
  echo -e "$logout\n$reboot\n$shutdown" | dmenu_cmd
}
chosen="$(run_dmenu)"
case ${chosen} in
$logout)
  run_cmd --logout
  ;;
$reboot)
  run_cmd --reboot
  ;;
$shutdown)
  run_cmd --shutdown
  ;;
esac
