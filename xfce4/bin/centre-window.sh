#!/bin/bash
# https://forum.xfce.org/viewtopic.php?id=11558
# Retrieved: 03/03/2025 16:57
# Requires: `xdotool`, `xdpyinfo`

IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)
# Hardcode when dual monitors, because it just combines them
#screenWidth=2560
# Subtract height of bottom panel off the screenheight
#screenHeight=$((screenHeight-34))

width=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
height=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')

newPosX=$((screenWidth/2-width/2))
newPosY=$((screenHeight/2-height/2))

xdotool getactivewindow windowmove "$newPosX" "$newPosY"

