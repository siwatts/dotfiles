#!/bin/bash
# - SW - 01/12/2022 21:58 -
# Install flatpaks from a file containing list of ids, starting with source
# They are concatanated after flatpak install command

user=
if [ "$1" == "--user" ] || [ "$1" == "-u" ]; then
    user="--user"
    shift
fi
if [ -z "$1" ]; then
    echo "ERROR: Give me a file containing flatpaks to install"
    exit 1
fi
if [ ! -f "$1" ]; then
    echo "ERROR: Cannot find file '$1'"
    exit 1
fi
filelist="$1"
shift
if [ "$1" == "--user" ] || [ "$1" == "-u" ]; then
    user="--user"
    shift
fi

# Install from file content
flatpak install $user "$@" $(cat "$filelist")

exit 0
