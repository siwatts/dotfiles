#!/bin/bash

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ ! -d "../../gnome" ]; then
    echo "ERROR: Called from wrong location"
    exit 1
fi

../load-dconf-settings.sh ../dconf-settings-1440p.ini
exit 0
