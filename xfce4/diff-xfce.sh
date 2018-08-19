#!/bin/bash
# Diff xfce config files.

if [ -f "xfce4/terminal/terminalrc" ]; then
    # Called from dotfiles root directory.
    PREFIX="xfce4/"
else if [ -f "terminal/terminalrc" ]; then
    # Called from dotfiles xfce4/ directory.
    PREFIX=""
else
    echo "Couldn't find 'terminal/terminalrc', where is this script being called from?"
    exit 1
fi

vim -d ~/.config/xfce4/terminal/terminalrc "$PREFIX"terminal/terminalrc &&
vim -d ~/.config/xfce4/xfconf/xfce-perchannel-xml/keyboards.xml "$PREFIX"xfconf/xfce-perchannel-xml/keyboards.xml &&
vim -d ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml "$PREFIX"xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml &&
vim -d ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml "$PREFIX"xfconf/xfce-perchannel-xml/xfce4-panel.xml &&
vim -d ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml "$PREFIX"xfconf/xfce-perchannel-xml/xfwm4.xml &&
vim -d ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml "$PREFIX"xfconf/xfce-perchannel-xml/xsettings.xml &&
vim -d ~/.config/xfce4/panel/whiskermenu-17.rc "$PREFIX"panel/whiskermenu-17.rc

