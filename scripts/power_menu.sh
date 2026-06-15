#!/usr/bin/env bash

if pidof rofi >/dev/null; then
  pkill rofi
fi

chosen=$(printf "Lock\nSuspend\nShutdown\nReboot\nLogout" |
  rofi -dmenu -i -p "Power " -no-show-icons)

case "$chosen" in
	"Lock") hyprlock ;;
	"Suspend") systemctl suspend ;;
	"Shutdown") systemctl poweroff ;;
	"Reboot") systemctl reboot ;;
	"Logout") hyprctl dispatch 'hl.dsp.exit()' ;;
	*) exit 1 ;;
esac
