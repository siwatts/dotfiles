#!/bin/bash
# Diff all dotfiles.

vim -d ~/.vimrc vim/vimrc &&
vim -d ~/.Xresources terminal/Xresources &&
vim -d ~/.bashrc bashrc &&
vim -d ~/.tmux.conf tmux.conf &&
vim -d ~/.gitconfig gitconfig &&
vim -d ~/.xinitrc xinitrc
