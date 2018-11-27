#!/bin/sh

# Touchpad Indicator Autostart
/usr/bin/python3 /usr/bin/touchpad-indicator &

sleep 3

# Touchpad Indicator monitor off
/usr/bin/touchpad-indicator -c

# Because you can not tap click, restart
/usr/bin/libinput-gestures-setup restart

# Touchpad Indicator monitor on
/usr/bin/touchpad-indicator -c
