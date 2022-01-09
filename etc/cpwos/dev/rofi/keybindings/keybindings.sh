#!/bin/bash

cat /etc/cpwos/dev/rofi/keybindings/keybindings | \
	rofi -dmenu \
	-theme /etc/cpwos/dev/rofi/keybindings/config.rasi \
	-p "CPW Dev OS Keybindings"
