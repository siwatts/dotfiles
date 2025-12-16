#!/bin/bash
# - SW - 16/12/2025 15:35 -
# Take the scripts in bin/ and softlink them to ~/bin, creating and adding to $PATH if necessary

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
    echo "# Added by SW dotfiles '$CURRENT_DIR/softlink-bin.sh' on $(date)" >> "$BASHRC"
    echo 'export PATH="$PATH:'"$PATH_TO_BIN"'"' >> "$BASHRC"
fi

# Soft-link, -f forces it, even if a file or softlink already exists there. -n no de-reference
echo "Softlinking scripts to '~/bin'..."
ln -sfn "$CURRENT_DIR/system-shutdown-timer.sh" "$PATH_TO_BIN"
ln -sfn "$CURRENT_DIR/system-shutdown-cancel.sh" "$PATH_TO_BIN"
echo "Done"

exit 0

