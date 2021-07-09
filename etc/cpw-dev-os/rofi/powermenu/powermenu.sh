#!/usr/bin/env bash

# Variables
theme="config"
dir="/etc/cpw-dev-os/rofi/powermenu"
uptime=$(uptime -p | sed -e 's/up //g')
rofi_command="rofi -theme $dir/$theme"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""
yes="Yes"
no="No"

# Arrays
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
confirm="$yes\n$no"

# Confirmation
confirm_exit() {
	echo -e "$confirm" | $rofi_command \
		-dmenu\
		-format s\
		-p "Are You Sure?"
}

# Show the powermenu
chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"

# Handle options
case $chosen in
	$shutdown)
		ans=$(confirm_exit &)
		if [[ "$ans" = "$yes" ]]; then
			systemctl poweroff
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
	;;
	$reboot)
		ans=$(confirm_exit &)
		if [[ "$ans" = "$yes" ]]; then
			systemctl reboot
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
	;;
	$lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock -c 295683
		else
			notify-send "No screen locker found."
		fi
	;;
	$suspend)
		ans=$(confirm_exit &)
		if [[ "$ans" = "$yes" ]]; then
			systemctl suspend
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
	;;
	$logout)
		ans=$(confirm_exit &)
		if [[ "$ans" = "$yes" ]]; then
			openbox --exit
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
        ;;
esac
