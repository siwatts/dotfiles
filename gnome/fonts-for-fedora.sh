#!/bin/bash
# - SW - 09/03/2023 22:34 -
# Install and apply settings for some nice fonts for Fedora, as of F38

# Fonts from Fedora repos
# Install our chosen font first, since we need it to work for the substitutions
sudo dnf install -y ibm-plex-fonts-all
if [ $? -eq 0 ]; then
    CUSTOMFONT=yes
else
    CUSTOMFONT=no
fi
# Other fonts may change in future versions of fedora and this command not be updated so could fail
sudo dnf install -y fira-code-fonts cascadia-fonts-all terminus-fonts google-droid-* google-go-* redhat-mono-fonts
sudo dnf install -y levien-inconsolata-fonts gnu-free-mono-fonts jetbrains-mono-fonts-all msimonson-anonymouspro-fonts
sudo dnf install -y google-roboto-mono-fonts
# Non monospace fonts for UI, like Inter
sudo dnf install -y rsms-inter-fonts
sudo dnf install -y dejavu-fonts-all google-roboto-fonts mozilla-fira-sans-fonts adobe-source-sans-pro-fonts

# Hack font, COPR: https://copr.fedorainfracloud.org/coprs/zawertun/hack-fonts/
# Repos for F37 and F38 as of 17/06/2023
sudo dnf copr enable zawertun/hack-fonts -y && sudo dnf install hack-fonts -y
if [ $? -eq 0 ]; then
    HACKFONT=yes
else
    HACKFONT=no
fi

## Set our new preferred default, currently IBM Plex Mono
#if [ "$CUSTOMFONT" == "yes" ]; then
#    # Equivalent to `dconf load /` of a file containing [org/gnome/desktop/interface] monospace-font-name=
#    echo "GNOME..."
#    gsettings set org.gnome.desktop.interface monospace-font-name 'IBM Plex Mono 10'
#
#    # GVim (font was previously 'Source Code Pro')
#    if [ -f ~/.vimrc ]; then
#        echo "GVim..."
#        sed -i 's/\(\s*\)set guifont=Source/\1"set guifont=Source/g' ~/.vimrc
#        sed -i 's/\(\s*\)"set guifont=IBM/\1set guifont=IBM/g' ~/.vimrc
#    else
#        echo "GVim... '~/.vimrc' not found"
#    fi
#
#    # neovim-qt
#    if [ -f ~/.config/nvim/ginit.vim ]; then
#        echo "neovim-qt..."
#        sed -i 's/^GuiFont Source/"GuiFont Source/g' ~/.config/nvim/ginit.vim
#        sed -i 's/^"GuiFont IBM/GuiFont IBM/g' ~/.config/nvim/ginit.vim
#    else
#        echo "neovim-qt... '~/.config/nvim/ginit.vim' not found"
#    fi
#
#    # Doom Emacs
#    if [ -f ~/.doom.d/config.el ]; then
#        echo "Doom Emacs..."
#        sed -i 's/Source Code Pro/IBM Plex Mono/g' ~/.doom.d/config.el
#    else
#        echo "Doom Emacs... '~/.doom.d/config.el' not found"
#    fi
#
#    echo "Font setting complete"
#fi

