#!/bin/bash
# Change urxvt font to first arg.
printf '\33]50;%s\007' $1
