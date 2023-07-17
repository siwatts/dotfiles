#!/bin/bash
# - SW - 23/11/2021 -
echo "SCRIPT DISABLED. READ AND MODIFY"
echo "Check and set the device paths e.g. 'dev:/dev/i2c-6' in 'monitor-update.sh'"
exit 1

# Store current brightness in a file
fname="/usr/local/bin/monitor-brightness.txt"

if [ -z "$1" ]; then
    tput setaf 1; tput bold
    echo "ERROR: Give integer brightness arg"
    tput sgr0
    exit 1
fi

# Brightness (0x10)
# Probe with sudo ddccontrol -p

# Take an arg for the brightness level
arg="$1"
re='^[0-9]+$'
if ! [[ $arg =~ $re ]] ; then
    tput setaf 1; tput bold
    echo 'Must be an integer!'
    tput sgr0
    exit 1
elif [ $arg -lt 0 ] || [ $arg -gt 100 ] ; then
    tput setaf 1; tput bold
    echo 'Brightness must be between 0-100!'
    tput sgr0
    exit 1
else
    echo -n "New brightness value: "
    tput setaf 2; tput bold
    echo "$arg"
    tput sgr0
fi

echo -n "Monitor 1... "
sudo ddccontrol -r 0x10 -w $arg dev:/dev/i2c-3 &> /dev/null
echo "Done"
echo -n "Monitor 2... "
sudo ddccontrol -r 0x10 -w $arg dev:/dev/i2c-4 &> /dev/null
echo "Done"

echo -n "Writing current brightness '"
tput setaf 2; tput bold
echo -n "$arg"
tput sgr0
echo -n "' to file... "
echo "$arg" > "$fname"
echo "Done"
tput setaf 2; tput bold
echo "Update Complete"
tput sgr0

