#!/bin/bash
# - SW - 02/12/2022 16:12 -

if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "ERROR: Give me a valid filepath to a '.desktop' file. Given: '$1'"
    exit 1
fi

if [ ! -d ~/.local/share/applications ]; then
    mkdir -p ~/.local/share/applications
fi

echo "Copying custom launcher: '$1' -> '~/.local/share/applications'"
cp -a "$1" ~/.local/share/applications

exit 0
