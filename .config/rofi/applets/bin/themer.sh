#!/usr/bin/env bash

## Custom Applets 
## Author : sol_

# Import theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"
themesecond="$typeapp/$styleapp"

prompt='Themer'

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='2'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
fi

rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

rofi_mat() {
  rofi -theme-str "listview {columns: 2; lines: 1;}" \
    -theme-str 'textbox-prompt-colon {str: "a";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${themesecond}
}

layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1="󰋩 Matugen <span weight='light' size='small'><i>($term_cmd)</i></span>"
	option_2="󰉋 Waybar Config <span weight='light' size='small'><i>($file_cmd)</i></span>"
	option_3="󰉋 Hyprland Config <span weight='light' size='small'><i>($text_cmd)</i></span>"
	option_4="󱈄 Select Directory <span weight='light' size='small'><i>($web_cmd)</i></span>"
else
	option_1=" "
	option_2="󰉋 "
	option_3=" "
	option_4="󱈄 "
fi


run_rofi() {
	echo -e "$option_3\n$option_4" | rofi_cmd
}

run_cmd() {	
	if [[ "$1" == '--opt3' ]]; then
		kitty --hold sh -c "nvim .config/hypr"

	elif [[ "$1" == '--opt4' ]]; then
		alacritty --command nvim $HOME
	fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
esac
