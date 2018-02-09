#!/bin/bash
# Diff all dotfiles on a server in vim.

vim -d ~/.vimrc vim/vimrc
vim -d ~/.bashrc ssh/server/bashrc
vim -d ~/.tmux.conf ssh/server/tmux.conf
