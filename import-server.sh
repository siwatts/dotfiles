#!/bin/bash
# - SW - 09/05/2023 23:30 -
# Import or softlink subset of dotfiles, intended to be safe for lean, headless, and/or remote server environments

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Are we in the right place
if [ ! -f "vim/vimrc" ]; then
    echo "ERROR: Run from root of dotfiles repo"
    exit 1
fi

echo "This script imports from dotfiles a subset of files that are well suited to a headless / server environment"
echo "If already present files are appended with '.bak' for later comparison, or opened for live diff"
echo
echo "Make sure vim is installed before proceeding"
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

echo
echo "Hint: Disable sudo password prompts with 'sudo visudo' and line"
echo "    %wheel        ALL=(ALL)       NOPASSWD: ALL"
echo
read -r -p "Run 'sudo visudo' with 'vi' now? (y/[N]): " response
case "$response" in
    [yY][eE][sS]|[yY])
        sudo EDITOR=vi visudo
        ;;
    *)
        ;;
esac

echo "Importing files..."

echo "Vimrc..."
if [ -f ~/.vimrc ]; then
    if [ -f ~/.vimrc.bak ]; then
        echo "ERROR: '~/.vimrc.bak' already exists, skipping..."
    else
        mv ~/.vimrc ~/.vimrc.bak
        cp -a vim/vimrc ~/.vimrc
    fi
else
    cp -a vim/vimrc ~/.vimrc
fi

# Vim colours
echo "Vim files..."
if [ -d ~/.vim ]; then
    echo "ERROR: '~/.vim' directory already exists, skipping..."
else
    mkdir -p ~/.vim/colors
    cp -a vim/colors ~/.vim
    cp -a vim/custom_colors/. ~/.vim/colors
    cp -a vim/syntax ~/.vim
    cp -a vim/plugin ~/.vim
    sed -i 's/^let use_custom_theme=0/let use_custom_theme=1/g' ~/.vimrc
    sed -i 's/^let use_truecolor=0/let use_truecolor=1/g' ~/.vimrc
    #sed -i 's/"set guifont=Source/set guifont=Source/g' ~/.vimrc
    #sed -i 's/set guifont=Monospace/"set guifont=Monospace/g' ~/.vimrc
fi

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

echo "Bashrc..."
# TODO: Make a minimal server safe .bashrc without too many aliases, git prompt etc.
if [ -f ~/.bashrc ]; then
    vim -d ~/.bashrc bashrc
else
    cp -a bashrc ~/.bashrc
    vim ~/.bashrc
fi

# Tmux.conf
echo "tmux.conf..."
cp -a tmux.conf ~/.tmux.conf
vim ~/.tmux.conf

# Git config
echo "gitconfig..."
cp -a gitconfig ~/.gitconfig
vim ~/.gitconfig

if [ ! -f ~/.ssh/id_ed25519.pub ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -a 100
fi
echo
echo "SSH public key:"
echo "--------------------------------------------------------------------------------"
cat ~/.ssh/id_ed25519.pub
echo "--------------------------------------------------------------------------------"

echo
echo "Done"

exit 0

