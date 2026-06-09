#!/usr/bin/env bash

if pidof rofi >/dev/null; then
  pkill rofi
fi

chosen=$(printf "Lock\nSuspend\nShutdown\nReboot\nLog Out" |
  rofi -dmenu -i -no-show-icons -theme-str 'inputbar { enabled: false; }')

case "$chosen" in
"Lock") hyprlock ;;
"Suspend") systemctl suspend ;;
"Shutdown") systemctl poweroff ;;
"Reboot") systemctl reboot ;;
"Log Out") hyprctl dispatch 'hl.dsp.exit()' ;;
*) exit 1 ;;
esac
