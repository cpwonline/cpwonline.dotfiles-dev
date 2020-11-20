#!/bin/csh

# view-apps.csh

switch($argv)
	case "--start":
		/usr/libexec/openbox-xdg-menu applications > /tmp/openbox_cpw_rc_applications
		/usr/libexec/openbox-xdg-menu preferences > /tmp/openbox_cpw_rc_preferences
		/usr/libexec/openbox-xdg-menu system-settings > /tmp/openbox_cpw_rc_settings
		/usr/libexec/openbox-xdg-menu /etc/xdg/openbox/terminals > /tmp/openbox_cpw_rc_terminals
		breaksw
	case "--restart":
		/usr/libexec/openbox-xdg-menu applications > /tmp/openbox_cpw_rc_applications
		/usr/libexec/openbox-xdg-menu preferences > /tmp/openbox_cpw_rc_preferences
		/usr/libexec/openbox-xdg-menu system-settings > /tmp/openbox_cpw_rc_settings
		/usr/libexec/openbox-xdg-menu /etc/xdg/openbox/terminals > /tmp/openbox_cpw_rc_terminals
		breaksw;
	case "--applications":
		cat /tmp/openbox_cpw_rc_applications
		breaksw
	case "--preferences":
		cat /tmp/openbox_cpw_rc_preferences
		breaksw
	case "--system-settings":
		cat /tmp/openbox_cpw_rc_settings
		breaksw
	case "--terminals":
		cat /tmp/openbox_cpw_rc_terminals
		breaksw
	default:
		echo "No option passed."
		breaksw
endsw
