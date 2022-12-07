#!/bin/bash
# - SW - 02/12/2022 17:07 -
# Sync all contents of dotfiles relevant to a GNOME desktop, interactively
# Assumes that initial set up has already been done and things are imported previously (e.g. import-all.sh)

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Are we in the right place
if [ ! -f "vim/vimrc" ]; then
    echo "ERROR: Run from root of dotfiles repo"
    exit 1
fi

echo "This script syncs from dotfiles to local system, assuming initial setup"
echo "has already been completed in the past"
echo "E.g. system was setup using dotfiles './import-all.sh' or similar"
echo
echo "It is intended to be idempotent but custom settings may be at risk of being overridden"
echo "INCLUDING things like any changes to vim colourschemes. They will be overwritten"
echo
read -r -p 'Do you wish to continue? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Okay"
        ;;
    *)
        exit 1
        ;;
esac

read -r -p "Is this a Silverblue install? (y/[N]): " silverblue
case "$silverblue" in
    [yY][eE][sS]|[yY])
        silverblue=yes
        ;;
    *)
        silverblue=no
        ;;
esac

echo "Importing files..."

# Vim colours
echo "Vim files..."
if [ ! -d ~/.vim ]; then
    echo "WARN: No '~/.vim' directory seen in home"
else
    cp -a vim/colors/. ~/.vim/colors
    cp -a vim/custom_colors/. ~/.vim/colors
    cp -a vim/syntax ~/.vim
fi

# Neovim
echo "Neovim init.vim and ginit.vim check softlink"
if [ -f ~/.config/nvim/init.vim ] && [ ! -L ~/.config/nvim/init.vim ]; then
    mv ~/.config/nvim/init.vim{,.bak}
fi
if [ -f ~/.config/nvim/ginit.vim ] && [ ! -L ~/.config/nvim/ginit.vim ]; then
    mv ~/.config/nvim/ginit.vim{,.bak}
fi
if [ ! -L ~/.config/nvim/init.vim ] || [ ! -L ~/.config/nvim/ginit.vim ]; then
    ln -sf `pwd`/vim/{,g}init.vim ~/.config/nvim
fi

# Xfce4-terminal
# Check xfce4-terminal is installed before softlinking all themes and making a custom launcher
if command -v xfce4-terminal &> /dev/null ; then
    echo "xfce4-terminal colours..."
    terminal/sync-xfce4-terminal-themes.sh
    echo "xfce4-terminal launcher..."
    launchers/create-launcher.sh launchers/xfce4-terminal.desktop
fi

# Home bin
echo 'Soft-link GNOME scripts to "~/bin", creating dir. and adding to ".bashrc" "$PATH" if necessary...'
gnome/softlink-gnome-bin.sh

# GNOME
read -r -p 'Load GNOME settings via dconf? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        # Idempotent settings, can be re-run later
        gnome/load-dconf-settings.sh gnome/dconf-settings.txt
        # Any firstrun settings that we later want to change to be in an update file (so far only xfce4-terminal)
        if command -v xfce4-terminal &> /dev/null ; then
            # Try update xfce4-terminal shortcut command
            gnome/load-dconf-settings.sh gnome/dconf-settings-firstrun-update-xfce4terminal.txt
        fi
        ;;
    *)
        ;;
esac

echo
echo "Import complete"

read -r -p 'Sync all installed flatpaks for ALL users? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        # Sync script for core & extras
        flatpak/sync-flatpak.sh
        # Prompt for silverblue if appr.
        if [[ "$silverblue" == "yes" ]]; then
            echo "Install extra flatpaks for Silverblue globally:"
            echo "--"
            cat flatpak/silverblue-core.txt
            echo "--"
            read -r -p 'Install the above flatpaks now for ALL users? (y/[N]): ' response
            case "$response" in
                [yY][eE][sS]|[yY])
                    flatpak/flatpak-install.sh flatpak/silverblue-core.txt -y
                    ;;
                *)
                    ;;
            esac
        fi
        ;;
    *)
        ;;
esac

echo "Diffing files..."
echo "Use ':cq' to exit vim with error code to terminate early"
read -r -p 'Diff all config files using vimdiff? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        ./diff-all.sh
        ;;
    *)
        ;;
esac

echo
echo "Program complete"

exit 0

