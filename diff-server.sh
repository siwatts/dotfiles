#!/bin/bash
# Diff all dotfiles on a server in vim.

vim -d ~/.vimrc vim/vimrc
vim -d ~/.bashrc bashrc
vim -d ~/.tmux.conf tmux.conf
