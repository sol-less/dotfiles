#!/bin/bash

FILE="/home/sol_/NYtrimmed.mp3"

# Runs mpv
mpv "$FILE" --no-video &
MPV_PID=$!
wait $MPV_PID

clear
notify-send "From Hyprland:" "You coded me, Arya. Thank you, and happy new year!"
sleep 1
echo "2025 is crazy, what about 2026?"
