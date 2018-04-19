#!/bin/bash
# - SW - 07/04/2018 -
# Determine whether it is day or night and call appropriate script.

HOUR="$(date +"%H")"

if [ "$HOUR" -lt "21" ]; then
    ~/bin/set_day_xfce_appearance.sh
else
    ~/bin/set_night_xfce_appearance.sh
fi

