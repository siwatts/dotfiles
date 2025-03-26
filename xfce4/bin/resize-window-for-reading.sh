#!/bin/bash
# - SW - 26/03/2025 20:28
# Resize the current window to a comfortable size for reading content
# Requires: `xdotool`, `xdpyinfo`

# Set the ratio of window/screen height
height=0.9

IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)
# Calculate the window height as a % of the screen height rounded to nearest int (using awk because bash cannot do floating point)
windowHeight=$(awk "BEGIN {print int($screenHeight * $height + 0.5)}")
# and 125px wider than it is tall
windowWidth=$((windowHeight+125))

# Resize
xdotool getactivewindow windowsize $windowWidth $windowHeight

