#!/bin/bash
while [ "$select" != "NO" -a "$select" != "YES" ]; do
    select=$(echo -e 'NO\nYES' | dmenu -nb '#000000' -nf '#f8f8f2' -sb '#ff79c6' -sf '#000000' -fn '-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*' -i -p "You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.")
    [ -z "$select" ] && exit 0
done
[ "$select" = "NO" ] && exit 0
i3-msg exit
