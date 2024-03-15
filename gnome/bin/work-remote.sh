#!/bin/bash

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ ! -d "../../gnome" ]; then
    echo "ERROR: Called from wrong location"
    exit 1
fi

../load-dconf-settings.sh ../dconf-settings-vm-or-remote.ini

# Switch wallpaper
#../load-dconf-settings.sh ../wallremote.ini

# Display scaling if we are using 1440p RDP
#../load-dconf-settings.sh ../dconf-settings-1440p.ini

# Enable Window List Extension
#gnome-extensions enable 'window-list@gnome-shell-extensions.gcampax.github.com'

exit 0
