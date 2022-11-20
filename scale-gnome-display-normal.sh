#!/bin/bash

# cd to root of git repo, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ ! -d "gnome" ]; then
    echo "ERROR: Call from root of git repo"
    exit 1
fi

gnome/load-dconf-settings.sh gnome/dconf-settings-1440p-undo.txt
exit 0
