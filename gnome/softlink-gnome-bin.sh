#!/bin/bash
# - SW - 20/11/2022 19:09 -
# Take the scripts in gnome/bin and softlink them to ~/bin, creating and adding to $PATH if necessary

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ -z "$HOME" ]; then
    echo 'ERROR: "$HOME" variable is empty. Cannot continue'
    exit 1
fi
PATH_TO_BIN="$HOME/bin"
BASHRC="$HOME/.bashrc"
CURRENT_DIR=`pwd`

if [ ! -d "$PATH_TO_BIN" ]; then
    echo "'$PATH_TO_BIN' does not exist. Creating..."
    mkdir "$PATH_TO_BIN"
    echo "Appending to '~/.bashrc' PATH variable..."
    echo >> "$BASHRC"
    echo "# Added by SW dotfiles '$CURRENT_DIR/softlink-gnome-bin.sh' on $(date)" >> "$BASHRC"
    echo 'export PATH="$PATH:'"$PATH_TO_BIN"'"' >> "$BASHRC"
fi

# Soft-link
echo "Softlinking scripts to '~/bin'..."
ln -s "$CURRENT_DIR/bin/sync-gnome-settings.sh" "$PATH_TO_BIN/sync-gnome-settings"
ln -s "$CURRENT_DIR/bin/scale-display-1440p.sh" "$PATH_TO_BIN/laptop-dock"
ln -s "$CURRENT_DIR/bin/scale-display-normal.sh" "$PATH_TO_BIN/laptop-undock"
echo "Done"

