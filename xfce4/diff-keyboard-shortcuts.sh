#!/bin/bash
# Diff xfce keyboard shortcut config file.

if [ -f "xfce4/terminal/terminalrc" ]; then
    # Called from dotfiles root directory.
    PREFIX="xfce4/"
elif [ -f "terminal/terminalrc" ]; then
    # Called from dotfiles xfce4/ directory.
    PREFIX=""
else
    echo "Couldn't find 'terminal/terminalrc', where is this script being called from?"
    exit 1
fi

vim -d ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml "$PREFIX"xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

