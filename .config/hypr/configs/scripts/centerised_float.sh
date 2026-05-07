#!/usr/bin/env bash

MONITORS=$(hyprctl monitors -j)
CLIENTS=$(hyprctl clients -j)

echo "$CLIENTS" | jq -c '.[] | select(.floating==true)' | while read -r c; do
  addr=$(echo "$c" | jq -r '.address')
  w=$(echo "$c" | jq '.size[0]')
  h=$(echo "$c" | jq '.size[1]')
  mon=$(echo "$c" | jq '.monitor')

  MON=$(echo "$MONITORS" | jq ".[] | select(.id==$mon)")
  MW=$(echo "$MON" | jq '.width')
  MH=$(echo "$MON" | jq '.height')
  MX=$(echo "$MON" | jq '.x')
  MY=$(echo "$MON" | jq '.y')

  x=$((MX + (MW - w) / 2))
  y=$((MY + (MH - h) / 2))

  hyprctl dispatch movewindowpixel exact "$x $y,address:$addr"
done
