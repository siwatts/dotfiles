#!/bin/bash
# - SW - 24/11/2021 -

# Store current brightness in a file
fname="/usr/local/bin/monitor-brightness.txt"

printf "Current brightness: "
cat "$fname"

