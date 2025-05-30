#!/bin/bash
# - SW - 20/11/2022 19:26 -
# Import or softlink all contents of dotfiles relevant to a GNOME desktop, interactively, for a clean install / user account

# Pretty helper
onemintimer()
{
    echo '60 second timer...'
    echo -ne '[                                                            ]\r'
    echo -ne '['

    for i in {1..60}; do
        sleep 1s
        echo -n '='
    done
    echo
}

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Are we in the right place
if [ ! -f "vim/vimrc" ]; then
    echo "ERROR: Run from root of dotfiles repo"
    exit 1
fi

echo "This script imports files from dotfiles to a clean install of a local system for the first time"
echo "If already present files are appended with '.bak' for later comparison"
echo "We assume you are setting up a desktop environment and want to import everything"
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

echo "Importing files..."

echo "Bashrc..."
if [ -f ~/.bashrc ]; then
    if [ -f ~/.bashrc.bak ]; then
        echo "ERROR: '~/.bashrc.bak' already exists"
        exit 1
    fi
    mv ~/.bashrc ~/.bashrc.bak
fi
cp -a bashrc ~/.bashrc

echo "Vimrc..."
if [ -f ~/.vimrc ]; then
    if [ -f ~/.vimrc.bak ]; then
        echo "ERROR: '~/.vimrc.bak' already exists"
        exit 1
    fi
    mv ~/.vimrc ~/.vimrc.bak
fi
cp -a vim/vimrc ~/.vimrc

# Vim colours
echo "Vim files..."
mkdir -p ~/.vim/colors
cp -a vim/colors ~/.vim
cp -a vim/custom_colors/. ~/.vim/colors
cp -a vim/syntax ~/.vim
cp -a vim/plugin ~/.vim
sed -i 's/^let use_custom_theme=0/let use_custom_theme=1/g' ~/.vimrc
sed -i 's/^let use_truecolor=0/let use_truecolor=1/g' ~/.vimrc
sed -i 's/"set guifont=IBM/set guifont=IBM/g' ~/.vimrc
sed -i 's/set guifont=Monospace/"set guifont=Monospace/g' ~/.vimrc

# Gitk, with modified fonts
echo "Gitk config..."
if [ ! -d ~/.config/git ]; then
    mkdir -p ~/.config/git
fi
if [ -f ~/.config/git/gitk ]; then
    mv ~/.config/git/gitk{,.bak}
fi
cp -a gitk ~/.config/git

# Neovim
echo "Neovim init.vim and ginit.vim..."
mkdir -p ~/.config/nvim
ln -sf `pwd`/vim/{,g}init.vim ~/.config/nvim

# Xfce4-terminal
echo "xfce4-terminal config..."
mkdir -p ~/.config/xfce4/terminal
cp -a xfce4/terminal/terminalrc ~/.config/xfce4/terminal
# No harm to bring in config file anyway, but check xfce4-terminal is installed
# before softlinking all themes and making a custom launcher
if command -v xfce4-terminal &> /dev/null ; then
    echo "xfce4-terminal colours..."
    terminal/sync-xfce4-terminal-themes.sh
fi

# Ptyxis terminal
echo "ptyxis themes..."
terminal/sync-ptyxis-terminal-themes.sh

# Tmux.conf
echo "tmux.conf..."
cp -a tmux.conf ~/.tmux.conf

# Git config
echo "gitconfig..."
cp -a gitconfig ~/.gitconfig

echo
echo "Import complete"

if [ -f ~/.bashrc.bak ]; then
    echo
    read -r -p 'Compare imported .bashrc to pre-existing .bashrc.bak? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            if command -v vim &> /dev/null ; then
                vim -d ~/.bashrc ~/.bashrc.bak
            else
                # Fallback if vim not installed
                diff ~/.bashrc ~/.bashrc.bak
            fi
            ;;
        *)
            ;;
    esac
fi
echo

echo
echo "Program complete"

exit 0

