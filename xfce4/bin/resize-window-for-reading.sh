#!/bin/bash
# - SW - 26/03/2025 20:28
# Resize the current window to a comfortable size for reading content
# Requires: `xdotool`, `xdpyinfo`

# Set the ratio of window size to screen height
height=0.95
width=1.1

IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)
# Hardcode when dual monitors, because it just combines them
#screenWidth=2560
# Subtract height of bottom panel off the screenheight
#screenHeight=$((screenHeight-34))
# Calculate the window height as a % of the screen height rounded to nearest int (using awk because bash cannot do floating point)
windowHeight=$(awk "BEGIN {print int($screenHeight * $height + 0.5)}")
windowWidth=$(awk "BEGIN {print int($screenHeight * $width + 0.5)}")

# Resize
xdotool getactivewindow windowsize $windowWidth $windowHeight

