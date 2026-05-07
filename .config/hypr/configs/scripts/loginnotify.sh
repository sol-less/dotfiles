#!/bin/bash

MESSAGES=(
  "Dont worry, we're not broken like Windows did."
  "Dont forget to sudo pacman -Syu"
  "touch grass bro"
  "Kendrick Lamar said : They not like us"
  "dont make me your chaotic experiment dawg"
  "SUPER + F, Session plan, Shutdown lil bro"
  "Day 1 of remembering sol_ to touch grass"
  "Thank god that girl break up with u gng"
  "Click clack those keyboard"
  "Idk what ur neighbour thought about ur keyboard"
)

RANDOM_MSG=${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}

notify-send "Hyprland" "$RANDOM_MSG"
