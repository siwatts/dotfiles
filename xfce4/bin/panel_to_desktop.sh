#!/bin/bash
# https://forum.xfce.org/viewtopic.php?id=9101

# Wait for all panels to load
while [ "$(wmctrl -l | grep -c xfce4-panel)" -lt "2" ];
do
   sleep 0.05s
done

# Determine identifier
ID=$(wmctrl -l | grep xfce4-panel | sed 3p | awk '{ print $1 }' | head -1)
ID2=$(wmctrl -l | grep xfce4-panel | sed 3p | awk '{ print $1 }' | tail -1)
# Place panel at desktop-level
wmctrl -i -r $ID -b add,below
wmctrl -i -r $ID2 -b add,below

