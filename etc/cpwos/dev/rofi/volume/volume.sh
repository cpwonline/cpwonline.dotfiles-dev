#!/usr/bin/env bash

rofi_command="rofi -theme /etc/cpwos/dev/rofi/volume/volume.rasi"

## Get Volume
MUTE=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $6}' | tr -d '[]%')

active=""
urgent=""

if [[ $MUTE == *"on"* ]]; then
    VOLUME="$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')%"
else
    VOLUME="Mute"
fi

## Icons
volume_up_text="Volume Up"
volume_down_text="Volume Down"
volume_mute_text="Mute"

volume_up="$volume_up_text\0icon\x1faudio-volume-high"
volume_down="$volume_down_text\0icon\x1f/usr/share/cpwos/reboot.png"
volume_mute="$volume_mute_text\0icon\x1f/usr/share/cpwos/lock.png"

# Arrays
options="$volume_up\n$volume_down\n$volume_mute"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$VOLUME" -dmenu -selected-row 0)"
case $chosen in
	$volume_up_text)
		amixer -Mq set Master,0 5%+ unmute && notify-send -u low -t 1500 "+5% Volume "
		;;
	$volume_down_text)
		amixer -Mq set Master,0 5%- unmute && notify-send -u low -t 1500 "-5% Volume"
		;;
	$volume_mute_text)
		amixer -q set Master toggle && notify-send -u low -t 1500 "Mute enable/disable"
		;;
esac

