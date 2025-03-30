#!/bin/bash
# - SW - 23/11/2021 -

# Store current brightness in a file
fname="/usr/local/bin/monitor-brightness.txt"

# Get current brightness from a file
if ! [ -f "$fname" ]; then
    notify-send "Monitor Adjust Down" "ERROR: File '$fname' not found"
    exit 1
fi
if [ -z "$1" ]; then
    notify-send "Monitor Adjust Down" "ERROR: Supply an integer amount to modify brightness by"
    exit 1
fi
mod=$1
# Read integer
typeset -i cur_bri="$(cat $fname)"

#echo "Current brightness: '$cur_bri'"

# Check its an integer
re='^[0-9]+$'
if ! [[ $cur_bri =~ $re ]] ; then
    notify-send "Monitor Adjust Down" "ERROR: Not a number"
    exit 1
fi

#echo "Subtracting $mod"
new_bri=$((cur_bri-mod))

#echo "Brightness will be '$new_bri'"

if [ $new_bri -lt 0 ] || [ $new_bri -gt 100 ] ; then
    notify-send "Monitor Adjust Down" "WARN: New brightness '$new_bri' out of bounds 0-100. Aborting"
    exit 1
fi

# If we got this far, good to try the update

# Remove the file as a crude form of concurrency prevention. Update command
# takes a second or 2 to run
sudo rm "$fname" || notify-send "Monitor Adjust Down" "ERROR: rm '$fname' failed!"

# Doing brightness update
#echo "--"
/usr/local/bin/monitor-update.sh $new_bri || echo "$cur_bri" | sudo tee "$fname" > /dev/null

