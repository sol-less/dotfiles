#!/bin/bash

pkill waybar -9
pkill swayosd-server -9
pkill swaync

waybar & disown
swayosd-server & disown
swaync & disown
