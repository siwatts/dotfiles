# About

Ptyxis terminal is the default terminal used by Fedora in Fedora 41

# Themes

Colour palettes are stored in `~/.local/share/org.gnome.Ptyxis/palettes`

Import all:

`cp -a terminal/ptyxis/custom-palettes/. ~/.local/share/org.gnome.Ptyxis/palettes`

# Gnome Terminal Palette

Fedora previously shipped `gnome-terminal`, which used the 'GNOME' terminal colours by default

However, for the default Fedora configuration the terminal background and foreground colours (`#1e1e1e`, `#ffffff`) were inherited from the system theme so do not match either of the 2 GNOME palettes for ptyxis (GNOME and GNOME Legacy)

The palette [gnome-fedora.palette](custom-palettes/gnome-fedora.palette) will replicate the old Fedora gnome-terminal look, it should be placed in the directory `~/.local/share/org.gnome.Ptyxis/palettes`

