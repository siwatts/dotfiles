#!/bin/bash

## Take a full screenshot, blur it, lock with it.
#scrot /tmp/screenshot.png
#convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
#i3lock -i /tmp/screenshotblur.png

## Slower, but no dependencies.
#i3lock -i <(import -window root - | convert -blur -1x5 - png:-)

## Lock using a static picture.
## This must be a .png for some reason.
#i3lock -i /usr/share/backgrounds/taeyeon_i_AL8AtY4.png -c 282a36

# Pixelated effect
# Modified from:
# https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/cqkmxxi/
#icon="$HOME/.xlock/icon.png"
tmpbg='/tmp/screen.png'
#(( $# )) && { icon=$1; }
scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
#convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
#i3lock -u -i "$tmpbg"
i3lock -i "$tmpbg"
