#!/usr/bin/env bash

rofi_command="rofi -theme /etc/cpwos/dev/rofi/volume/volume.rasi"

# Volume state
mute_state=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $6}' | tr -d '[]%')
volume_level="$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')%"

if [[ $mute_state == *"on"*  ]]; then
	volume_final=$volume_level
else
	volume_final="Muted"
fi

## Icons
volume_up_text="Volume Up"
volume_down_text="Volume Down"
volume_mute_text="Mute"

volume_up="$volume_up_text\0icon\x1faudio-volume-high"
volume_down="$volume_down_text\0icon\x1faudio-volume-low"
volume_mute="$volume_mute_text\0icon\x1faudio-volume-muted"

# Arrays
options="$volume_up\n$volume_down\n$volume_mute"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$volume_final" -dmenu -selected-row 0)"
case $chosen in
	$volume_up_text)
		/usr/bin/cpwos/volume_up.sh
		;;
	$volume_down_text)
		/usr/bin/cpwos/volume_down.sh
		;;
	$volume_mute_text)
		/usr/bin/cpwos/volume_mute.sh
		;;
esac

