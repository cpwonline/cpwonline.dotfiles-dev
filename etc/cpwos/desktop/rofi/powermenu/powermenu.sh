#!/usr/bin/env bash

# Variables
theme1="config-powermenu"
theme2="config-dialog"
dir="/etc/cpwos/desktop/rofi/powermenu"
uptime=$(uptime -p | sed -e 's/up //g')
rofi_command="rofi -theme $dir/$theme1"
rofi_dialog="rofi -theme $dir/$theme2"

# Options

shutdown_text="0"
reboot_text="1"
lock_text="2"
suspend_text="3"
logout_text="4"

shutdown="$shutdown_text\0icon\x1f/usr/share/cpwos/poweroff.png"
reboot="$reboot_text\0icon\x1f/usr/share/cpwos/reboot.png"
lock="$lock_text\0icon\x1f/usr/share/cpwos/lock.png"
suspend="$suspend_text\0icon\x1f/usr/share/cpwos/suspend.png"
logout="$logout_text\0icon\x1f/usr/share/cpwos/logout.png"

yes="Yes"
no="No"

# Arrays
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
confirm="$yes\n$no"

# Confirmation
confirm_dialog() {
	echo -e "$confirm" | $rofi_dialog \
		-dmenu\
		-format s\
		-p "Are You Sure?"
}

# Show the powermenu
chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"

# Handle options
case $chosen in
	$shutdown_text)
		ans=$(confirm_dialog &)
		if [[ "$ans" = "$yes" ]]; then
			systemctl poweroff
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
	;;
	$reboot_text)
		ans=$(confirm_dialog &)
		if [[ "$ans" = "$yes" ]]; then
			systemctl reboot
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
	;;
	$lock_text)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock -c 295683
		else
			notify-send "No screen locker found."
		fi
	;;
	$suspend_text)
		ans=$(confirm_dialog &)
		if [[ "$ans" = "$yes" ]]; then
			systemctl suspend
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
	;;
	$logout_text)
		ans=$(confirm_dialog &)
		if [[ "$ans" = "$yes" ]]; then
			openbox --exit
		elif [[ "$ans" = "$no" ]]; then
			exit 0
		fi
        ;;
esac
