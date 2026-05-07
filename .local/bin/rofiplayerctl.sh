#!/bin/bash

status=$(playerctl --player=spotify status 2>/dev/null)
shuffle=$(playerctl --player=spotify shuffle 2>/dev/null)

if [ "$status" = "Playing" ]; then
  toggle="⏸   Pause"
else
  toggle="▶   Play"
fi

if [ "$shuffle" = "On" ]; then
  shuffle_toggle="󰒞    Disable Shuffle"
else
  shuffle_toggle="    Activate Shuffle"
fi

choice=$(printf "%s\n⏭    Next\n⏮    Previous\n%s\n" "$toggle" "$shuffle_toggle" | rofi -dmenu -p "󰠃  " -theme-str 'entry { placeholder: "Playerctl.."; }' -no-show-icons)

case "$choice" in
  *Next*) swayosd-client --player spotify --playerctl next ;;
  *Play* | *Pause*) swayosd-client --player spotify --playerctl play-pause ;;
  *Previous*) swayosd-client --player spotify --playerctl previous ;;
  *Shuffle*) swayosd-client --player spotify --playerctl shuffle ;;
esac
