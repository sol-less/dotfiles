#!/usr/bin/env bash

BIRTHDAY=$(cat ~/.config/cached/birthday)
TODAY=$(date +%m-%d)

if [ "$TODAY" = "$BIRTHDAY" ]; then
  notify-send "From Hyprland:" "If no one says happy birthday to you, i will. Happy Birthday"
fi
