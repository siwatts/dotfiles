#!/bin/bash
# - SW - 30/06/2022 12:02 -
# Set PS1 by hashing hostname
# https://www.xfree86.org/current/ctlseqs.html
# TODO: Clean this up, port to PS1 in .bashrc

HOST=$HOSTNAME
HOST="${HOSTNAME%%.*}"
#SUM="$(echo $HOST | sha256sum -)"
SUM="$(echo $HOST | md5sum -)"
COLOUR="${SUM:0:6}"

echo "Hostname is '$HOST'"
echo "Checksum is '$SUM'"
echo "Colour is '#$COLOUR'"

#echo "Red component: '${COLOUR:0:2}' = '$((16#${COLOUR:0:2}))'"
#echo "Green component: '${COLOUR:2:2}' = '$((16#${COLOUR:2:2}))'"
#echo "Blue component: '${COLOUR:4:2}' = '$((16#${COLOUR:4:2}))'"

# Echos 255,0,0 (red)
echo -e "\033[38;2;255;0;02m####\033[m"
# Bold red
echo -e "\033[1;38;2;255;0;02m####\033[m"

echo -e '\033[1;38;2;'"$((16#${COLOUR:0:2}));$((16#${COLOUR:2:2}));$((16#${COLOUR:4:2}))m$HOST"'\033[m'
#echo -e '\033[1;38;2;'"$((16#${COLOUR:0:2}));$((16#${COLOUR:2:2}));$((16#${COLOUR:4:2}))m"'\u@\h \[\033[01;34m\]\w\033[m\n\$ '

