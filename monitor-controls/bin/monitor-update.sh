#!/bin/bash
# - SW - 23/11/2021 -
echo "SCRIPT DISABLED. READ AND MODIFY"
echo "Check and set the device paths e.g. 'dev:/dev/i2c-6' in 'monitor-update.sh'"
exit 1

# Store current brightness in a file
fname="/usr/local/bin/monitor-brightness.txt"

if [ -z "$1" ]; then
    echo "Give integer brightness arg"
    exit 1
fi

# Brightness (0x10)
# Probe with sudo ddccontrol -p

# Take an arg for the brightness level
arg="$1"
re='^[0-9]+$'
if ! [[ $arg =~ $re ]] ; then
    echo 'Must be an integer!'
    exit 1
elif [ $arg -lt 0 ] || [ $arg -gt 100 ] ; then
    echo 'Brightness must be between 0-100!'
    exit 1
else
    echo "Given number '$arg'"
fi

# Tie the 2nd monitor to the first
# When primary monitor dips below certain threshold, tie monitor 2 brightness to monitor 1 + X
if [ $arg -gt 0 ] && [ $arg -lt 25 ] ; then
    mon2=$((arg+15))
    echo "Calc. Mon2 to '$mon2'"
elif [ $arg -ge 25 ] && [ $arg -lt 60 ] ; then
    mon2=$((arg+20))
    echo "Calc. Mon2 to '$mon2'"
elif [ $arg -eq 0 ] ; then
    mon2=0
    echo "Default Mon2 to '$mon2'"
else
    mon2=100
    echo "Default Mon2 to '$mon2'"
fi

# Check mon2 separately
if [ $mon2 -lt 0 ] || [ $mon2 -gt 100 ] ; then
    echo 'Brightness for MON2 must be between 0-100!'
    exit 1
fi

echo "Monitor 1..."
# sudo ddccontrol -r 0x10 -w $arg dev:/dev/i2c-6 &> /dev/null
echo "Monitor 2..."
# sudo ddccontrol -r 0x10 -w $mon2 dev:/dev/i2c-1 &> /dev/null

echo "Writing current brightness '$arg' to file"
echo "$arg" | sudo tee "$fname" > /dev/null
echo "Done"

