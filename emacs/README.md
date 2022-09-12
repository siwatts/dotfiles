# Doom Emacs

## About

A distribution for Emacs called Doom emulates vim almost entirely and provides
many other features

Find and [install it here](https://github.com/hlissner/doom-emacs)

## Config

Configuration files are generated in `~/.doom.d` at install. Configuration is
to be done here, not in `~/.emacs.d`.

It is probably best to diff the files in this repository against those created
by Doom at install, since they are periodically updated with new Doom features
or other changes.

Some modifications made by my config:
- Increase timeout of jk/kj insert mode ESC map
- Starting window size
- Remove annoying autocompletion popups
    - Can still be called for via vim keybinds `^p` etc.
- Disable mouse globally
    - MELPA package `disable-mouse`
    - Requires an additional step to unbind evil mode keybinds, since Doom uses
      evil

## How To

Get `doom` command
- Add `.emacs.d/bin` to `$PATH`

Install MELPA packages
- Add to `~/.doom.d/packages.el`
- Run `doom sync`

