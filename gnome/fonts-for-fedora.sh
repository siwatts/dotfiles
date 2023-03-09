#!/bin/bash
# - SW - 09/03/2023 22:34 -
# Install and apply settings for some nice fonts for Fedora, as of F37

# Hack font, COPR: https://copr.fedorainfracloud.org/coprs/zawertun/hack-fonts/
# Repos for F37 and F38 as of 09/03/2023 (Fedora 38 currently in beta)
sudo dnf copr enable zawertun/hack-fonts -y && sudo dnf install hack-fonts -y
if [ $? -eq 0 ]; then
    HACKFONT=yes
else
    HACKFONT=no
fi

# Other nice fonts from Fedora repos
sudo dnf install -y fira-code-fonts cascadia-fonts-all terminus-fonts google-droid-* google-go-* redhat-mono-fonts
# Bitstream vera, and bitmap fonts?

# Set our new preferred default, currently hack font if the COPR installed
if [ "$HACKFONT" == "yes" ]; then
    # Equivalent to `dconf load /` of a file containing [org/gnome/desktop/interface] monospace-font-name=
    echo "GNOME..."
    gsettings set org.gnome.desktop.interface monospace-font-name 'Hack 10'

    # GVim (font was previously 'Source Code Pro')
    if [ -f ~/.vimrc ]; then
        echo "GVim..."
        sed -i 's/\(\s*\)set guifont=Source/\1"set guifont=Source/g' ~/.vimrc
        sed -i 's/\(\s*\)"set guifont=Hack\\ 10/\1set guifont=Hack\\ 10/g' ~/.vimrc
    else
        echo "GVim... '~/.vimrc' not found"
    fi

    # neovim-qt
    if [ -f ~/.config/nvim/ginit.vim ]; then
        echo "neovim-qt..."
        sed -i 's/^GuiFont Source/"GuiFont Source/g' ~/.config/nvim/ginit.vim
        sed -i 's/^"GuiFont Hack/GuiFont Hack/g' ~/.config/nvim/ginit.vim
    else
        echo "neovim-qt... '~/.config/nvim/ginit.vim' not found"
    fi

    # Doom Emacs
    if [ -f ~/.doom.d/config.el ]; then
        echo "Doom Emacs..."
        sed -i 's/Source Code Pro/Hack/g' ~/.doom.d/config.el
    else
        echo "Doom Emacs... '~/.doom.d/config.el' not found"
    fi

    echo "Font setting complete"
fi

