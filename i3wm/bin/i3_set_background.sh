#!/bin/bash
# - SW - 29/04/2018 -
# Set a random background with feh periodically.
while true; do
    feh --randomize --bg-fill ~/Pictures/wallpaper/*
    sleep 900 # 15 minutes.
    #sleep 1800 # 30 minutes.
done
