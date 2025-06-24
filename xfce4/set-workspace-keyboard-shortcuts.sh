#!/bin/bash
# - 24/06/2025 - SW -
# Overload workspace switching shortcuts by adding some extras to Keyboard (defaults are in Workspace Settings)
# Requires: `xdotool`

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

echo "Setting additional workspace shortcuts with 'xfconf-query'..."

# Keyboard shortcuts
# This did not always work before, but seems fixed as of xfce 4.18 with <Primary> used for Ctrl key
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>1' --type 'string' --set 'xdotool set_desktop 0'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>2' --type 'string' --set 'xdotool set_desktop 1'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>3' --type 'string' --set 'xdotool set_desktop 2'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>4' --type 'string' --set 'xdotool set_desktop 3'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>5' --type 'string' --set 'xdotool set_desktop 4'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>6' --type 'string' --set 'xdotool set_desktop 5'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>7' --type 'string' --set 'xdotool set_desktop 6'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>8' --type 'string' --set 'xdotool set_desktop 7'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>9' --type 'string' --set 'xdotool set_desktop 8'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>Page_Down' --type 'string' --set 'xdotool set_desktop --relative 1'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>Page_Up' --type 'string' --set 'xdotool set_desktop --relative -- -1'

echo "Shortcut settings complete."
exit 0

