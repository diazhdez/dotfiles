#!/usr/bin/env bash

if pidof rofi >/dev/null; then
  pkill rofi
fi

cliphist list | rofi -dmenu -i -p "Clipboard " -display-columns 2 -no-show-icons | cliphist decode | wl-copy
