#!/bin/bash

if [ -z "$1" ]; then
    echo "ERROR: Give me a file containing dconf settings to load"
    exit 1
elif [ ! -f "$1" ]; then
    echo "ERROR: I don't see the file '"$1"'"
    exit 1
fi

echo "Loading settings '$1' with dconf..."
cat "$1" | dconf load /
echo "Done"

