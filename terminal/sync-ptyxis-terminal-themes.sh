#!/bin/bash
# If you use this THEMESDIR variable everything breaks...
THEMESDIR="~/.local/share/org.gnome.Ptyxis/palettes"
SOURCE1=
if [ -d "terminal" ]; then
    # Repo root
    SOURCE1="terminal/ptyxis/custom-palettes"
elif [ -d "ptyxis" ]; then
    # Terminal subdir
    SOURCE1="ptyxis/custom-palettes"
else
    echo "ERROR: Don't see any themes to source"
    exit 1
fi

if [ -d ~/.local/share/org.gnome.Ptyxis/palettes ]; then
    # Destination dir exists and...
    if [ ! -z "$(ls -A ~/.local/share/org.gnome.Ptyxis/palettes)" ]; then
        # Not empty
        echo "================================================================================"
        ls -CF ~/.local/share/org.gnome.Ptyxis/palettes
        echo "================================================================================"
        echo "WARNING: Destination directory not empty. Current contents listed above. Any unsaved changes will be lost"
        read -r -p 'All listed files or softlinks will be removed. Continue? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                rm -f ~/.local/share/org.gnome.Ptyxis/palettes/*.palette
                ;;
            *)
                echo "Abort theme sync"
                exit 1
                ;;
        esac
    fi
else
    mkdir -p ~/.local/share/org.gnome.Ptyxis/palettes
fi

echo "Creating softlinks to '$THEMESDIR'..."
ln -s `pwd`/"$SOURCE1"/*.palette ~/.local/share/org.gnome.Ptyxis/palettes
echo "Done"

exit 0
