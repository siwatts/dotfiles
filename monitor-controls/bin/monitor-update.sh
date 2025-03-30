#!/bin/bash
# - SW - 23/11/2021 -
echo "SCRIPT DISABLED. READ AND MODIFY"
echo "Check and set the device paths e.g. 'dev:/dev/i2c-6' in 'monitor-update.sh'"
exit 1

# Store current brightness in a file
fname="/usr/local/bin/monitor-brightness.txt"

if [ -z "$1" ]; then
    notify-send "Monitor Update" "ERROR: Give integer brightness arg"
    exit 1
fi

# Brightness (0x10)
# Probe with sudo ddccontrol -p

# Take an arg for the brightness level
arg="$1"
re='^[0-9]+$'
if ! [[ $arg =~ $re ]] ; then
    notify-send "Monitor Update" "ERROR: Must be an integer! Got '$arg'"
    exit 1
elif [ $arg -lt 0 ] || [ $arg -gt 100 ] ; then
    notify-send "Monitor Update" "ERROR: Brightness '$arg' out of bounds 0-100. Aborting"
    exit 1
fi

notify-send -e "Monitor Update" "Brightness: $arg"
sudo ddccontrol -r 0x10 -w $arg dev:/dev/i2c-4 &> /dev/null

echo "$arg" | sudo tee "$fname" > /dev/null

