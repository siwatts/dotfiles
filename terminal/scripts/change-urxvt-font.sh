#!/bin/bash
# Change urxvt font to first arg.
if [ -n "$TMUX" ]; then
    # Tell tmux to pass the escape sequences through
    # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
    printf '\033Ptmux;\33\33]50;%s\007\33\\' $1
else
    printf '\33]50;%s\007' $1
fi
