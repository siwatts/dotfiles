#!/bin/bash

if [ -z "$1" ]; then
    echo "Provide a number between -1 and 1, default 0"
    exit 1
fi

gsettings set org.gnome.desktop.peripherals.mouse speed "$1"
exit 0

