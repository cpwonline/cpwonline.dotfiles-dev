#!/bin/bash

cat /etc/cpw-dev-os/rofi/keybindings/keybindings | \
	rofi -dmenu \
	-theme /etc/cpw-dev-os/rofi/keybindings/config.rasi \
	-p "CPW Dev OS Keybindings"
