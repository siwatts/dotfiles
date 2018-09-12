#!/bin/bash
while [ "$select" != "NO" -a "$select" != "YES" ]; do
    select=$(echo -e 'NO\nYES' | dmenu -nb '#000000' -nf '#f8f8f2' -sb '#ff79c6' -sf '#000000' -fn '-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*' -i -p "You pressed the sleep shortcut. Do you really want to suspend the system?")
    [ -z "$select" ] && exit 0
done
[ "$select" = "NO" ] && exit 0
i3lock -i /usr/share/backgrounds/lock2.png &&
systemctl suspend
