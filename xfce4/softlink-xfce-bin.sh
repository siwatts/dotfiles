#!/bin/bash
# - SW - 26/05/2025 18:52 -
# Take the scripts in xfce4/bin and softlink them to ~/bin, creating and adding to $PATH if necessary

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
    echo "# Added by SW dotfiles '$CURRENT_DIR/softlink-xfce-bin.sh' on $(date)" >> "$BASHRC"
    echo 'export PATH="$PATH:'"$PATH_TO_BIN"'"' >> "$BASHRC"
fi

# Soft-link, -f forces it, even if a file or softlink already exists there. -n no de-reference
echo "Softlinking scripts to '~/bin'..."
ln -sfn "$CURRENT_DIR/bin/centre-window.sh" "$PATH_TO_BIN"
ln -sfn "$CURRENT_DIR/bin/resize-window-for-reading.sh" "$PATH_TO_BIN"
echo "Done"

exit 0

