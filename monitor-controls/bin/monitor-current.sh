#!/bin/bash
# - SW - 24/11/2021 -

# Store current brightness in a file
fname="/usr/local/bin/monitor-brightness.txt"

val=`cat "$fname"`
notify-send -e "Current Brightness" $val

