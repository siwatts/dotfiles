#!/bin/bash
if [ ! -d "gnome" ]; then
    echo "ERROR: Call from root of git repo"
    exit 1
fi

gnome/load-dconf-settings.sh gnome/dconf-settings.txt
exit 0
