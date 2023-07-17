#!/bin/bash
# - SW - 23/11/2021 -

# Store current brightness in a file
fname="/usr/local/bin/monitor-brightness.txt"

# Get current brightness from a file
if ! [ -f "$fname" ]; then
    tput setaf 1; tput bold
    echo "File '$fname' not found"
    tput sgr0
    exit 1
fi
# Read integer
typeset -i cur_bri="$(cat $fname)"

#echo "Current brightness: '$cur_bri'"

# Check its an integer
re='^[0-9]+$'
if ! [[ $cur_bri =~ $re ]] ; then
   echo "Error: Not a number" >&2; exit 1
fi

#echo "Adding 10"
new_bri=$((cur_bri+10))

#echo "Brightness will be '$new_bri'"

if [ $new_bri -lt 0 ] || [ $new_bri -gt 100 ] ; then
    tput setaf 1; tput bold
    echo "WARN: New brightness '$new_bri' out of bounds 0-100. Aborting"
    tput sgr0
    exit 1
fi

# If we got this far, good to try the update

# Remove the file as a crude form of concurrency prevention. Update command
# takes a second or 2 to run
sudo rm "$fname" || echo "rm '$fname' failed!"

# Doing brightness update
#echo "--"
/usr/local/bin/monitor-update.sh $new_bri || echo "$cur_bri" | sudo tee "$fname" > /dev/null

