#!/bin/bash
# Get the current volume percentage of the active output sink.
SINK=0
pactl get-sink-volume $SINK | head -n1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1%,'
