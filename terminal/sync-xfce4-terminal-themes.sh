#!/bin/bash
# If you use this THEMESDIR variable everything breaks...
THEMESDIR="~/.local/share/xfce4/terminal/colorschemes"
SOURCE1=
SOURCE2=
SOURCEDEFAULT=
if [ -d "terminal" ]; then
    # Repo root
    SOURCE1="terminal/xfce4-terminal/colorschemes"
    SOURCE2="terminal/xfce4-terminal/custom_colorschemes"
    SOURCEDEFAULT="terminal/xfce4-terminal/default_colorschemes"
elif [ -d "xfce4-terminal" ]; then
    # Terminal subdir
    SOURCE1="xfce4-terminal/colorschemes"
    SOURCE2="xfce4-terminal/custom_colorschemes"
    SOURCEDEFAULT="xfce4-terminal/default_colorschemes"
else
    echo "ERROR: Don't see any themes to source"
    exit 1
fi

if [ -d ~/.local/share/xfce4/terminal/colorschemes ]; then
    # Destination dir exists and...
    if [ ! -z "$(ls -A ~/.local/share/xfce4/terminal/colorschemes)" ]; then
        # Not empty
        echo "================================================================================"
        ls -CF ~/.local/share/xfce4/terminal/colorschemes
        echo "================================================================================"
        echo "WARNING: Destination directory not empty. Current contents listed above. Any unsaved changes will be lost"
        read -r -p 'All listed files or softlinks will be removed. Continue? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                rm -f ~/.local/share/xfce4/terminal/colorschemes/*.theme
                ;;
            *)
                echo "Abort theme sync"
                exit 1
                ;;
        esac
    fi
else
    mkdir -p ~/.local/share/xfce4/terminal/colorschemes
fi

echo "Creating softlinks to '$THEMESDIR'..."
ln -s `pwd`/"$SOURCE1"/*.theme ~/.local/share/xfce4/terminal/colorschemes
ln -s `pwd`/"$SOURCE2"/*.theme ~/.local/share/xfce4/terminal/colorschemes
ln -s `pwd`/"$SOURCEDEFAULT"/xubuntu-*.theme ~/.local/share/xfce4/terminal/colorschemes
echo "Done"

exit 0
