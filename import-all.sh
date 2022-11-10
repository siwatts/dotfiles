#!/bin/bash
if [ ! -f "vim/vimrc" ]; then
    echo "ERROR: Run from root of dotfiles repo"
    exit 1
fi

echo "Hint: Disable sudo password prompts with 'sudo visudo' and line"
echo "    %wheel        ALL=(ALL)       NOPASSWD: ALL"
echo
echo "This script imports files from dotfiles to a clean install of a local system for the first time"
echo "If already present files are appended with '.bak' for later comparison"
echo "We assume you are setting up a DE like GNOME and want to import everything"
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

read -r -p 'Set hostname of new system? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        read -p 'Enter desired hostname: ' NEWHOSTNAME
        if [[ -z "$NEWHOSTNAME" ]]; then
            # Also catches whitespace
            echo "Error: Cannot be blank."
            exit 1
        else
            sudo hostnamectl set-hostname "$NEWHOSTNAME"
        fi
        ;;
    *)
        ;;
esac

echo "Recommended Fedora packages:"
echo "    - git"
echo "    - tmux"
echo "    - xfce4-terminal"
echo "    - vim-enhanced"
echo "    - vim-X11"
echo "    - neovim-qt"
echo "    - gnome-extensions-app"
echo "    - gnome-tweaks"
echo "    - gimp"
echo "    - remmina"
echo "    - htop"
echo "    - mediawriter"
echo "It is HIGHLY RECOMMENDED that you dnf upgrade all packages and reboot before doing this if this is a clean install, as dnf can error otherwise"
read -r -p 'DNF upgrade all packages and reboot now? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Working..."; sudo dnf offline-upgrade download -y && echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && sleep 1m && sudo dnf offline-upgrade reboot
        ;;
    *)
        ;;
esac
read -r -p 'Install recommended packages now via dnf? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Working..."
        sudo dnf install -y git tmux xfce4-terminal vim-enhanced vim-X11 neovim-qt gnome-extensions-app gnome-tweaks gimp remmina htop mediawriter
        ;;
    *)
        ;;
esac

echo "Importing files..."

echo "Bashrc..."
if [ -f "~/.bashrc" ]; then
    if [ -f "~/.bashrc.bak" ]; then
        echo "ERROR: '~/.bashrc.bak' already exists"
        exit 1
    fi
    mv "~/.bashrc ~/.bashrc.bak"
fi
cp -a bashrc ~/.bashrc

echo "Vimrc..."
if [ -f "~/.vimrc" ]; then
    if [ -f "~/.vimrc.bak" ]; then
        echo "ERROR: '~/.vimrc.bak' already exists"
        exit 1
    fi
    mv "~/.vimrc ~/.vimrc.bak"
fi
cp -a vim/vimrc ~/.vimrc

# Vim colours
echo "Vim files..."
mkdir -p ~/.vim/colors
cp -a vim/colors/. ~/.vim/colors
cp -a vim/custom_colors/. ~/.vim/colors
cp -a vim/syntax ~/.vim
sed -i 's/^let use_custom_theme=0/let use_custom_theme=1/g' ~/.vimrc
sed -i 's/^let use_truecolor=0/let use_truecolor=1/g' ~/.vimrc
sed -i 's/"set guifont=Source/set guifont=Source/g' ~/.vimrc
sed -i 's/set guifont=Monospace/"set guifont=Monospace/g' ~/.vimrc

# Xfce4-terminal
echo "xfce4-terminal config..."
mkdir -p ~/.config/xfce4/terminal
cp -a xfce4/terminal/terminalrc ~/.config/xfce4/terminal
echo "xfce4-terminal colours..."
mkdir -p ~/.local/share/xfce4/terminal/colorschemes
ln -s `pwd`/terminal/xfce4-terminal/colorschemes/* ~/.local/share/xfce4/terminal/colorschemes
ln -s `pwd`/terminal/xfce4-terminal/custom_colorschemes/* ~/.local/share/xfce4/terminal/colorschemes

# Tmux.conf
echo "tmux.conf..."
cp -a tmux.conf ~/.tmux.conf

# GNOME
read -r -p 'Load GNOME settings via dconf? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Loading settings via dconf..."
        cat gnome/dconf-settings.txt | dconf load /
        echo "Done"
        read -r -p 'Enable 1.2x scaling for 1440p displays? (y/[N]): ' response2
        case "$response2" in
            [yY][eE][sS]|[yY])
                echo "Loading more settings via dconf..."
                gnome/dconf-settings-1440p.txtdconf load /
                echo "Done"
                ;;
            *)
                ;;
        esac
        ;;
    *)
        ;;
esac

echo
echo "Import complete"

if [ -f "~/.bashrc.bak" ]; then
    echo
    read -r -p 'Compare imported .bashrc to pre-existing .bashrc.bak? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            vim -d ~/.bashrc ~/.bashrc.bak
            ;;
        *)
            ;;
    esac
fi
echo

if [ ! -d "~/.ssh" ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -a 100
fi

echo
echo "Program complete"

exit 0

