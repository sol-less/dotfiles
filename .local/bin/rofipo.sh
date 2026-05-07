#!/bin/bash

options="󰐥\n󰜉\n󰤄\n󰝳 \n󰍃"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "󰤁  " -theme-str 'entry { placeholder: "Session Plan.."; }' -no-show-icons -config $HOME/.local/share/rofi/themes/theme/powermenu.rasi)

case "$chosen" in
*"󰐥")
  systemctl poweroff
  ;;
*"󰜉")
  systemctl reboot
  ;;
*"󰤄")
  systemctl suspend
  ;;
*"󰝳 ")
  sleep 0.5
  ./.config/hypr/scripts/greetfront || loginctl lock-session
  ;;
*"󰍃")
  hyprctl dispatch exit
  ;;
esac
