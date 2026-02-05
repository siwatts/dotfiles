# About

Ptyxis terminal is the default terminal used by Fedora in Fedora 41

# Themes

Colour palettes are stored in
- Native: `~/.local/share/org.gnome.Ptyxis/palettes`
- Flatpak: `~/.var/app/app.devsuite.Ptyxis/data/app.devsuite.Ptyxis/palettes`

Import all:

```
PTYXISDIR="$HOME/.local/share/org.gnome.Ptyxis/palettes"
# OR
PTYXISDIR="$HOME/.var/app/app.devsuite.Ptyxis/data/app.devsuite.Ptyxis/palettes"
# Then
ln -s $HOME/repos/dotfiles/terminal/ptyxis/custom-palettes/*.palette "$PTYXISDIR"
```

# Gnome Terminal Palette

Fedora previously shipped `gnome-terminal`, which used the 'GNOME' terminal colours by default

However, for the default Fedora configuration the terminal background and foreground colours (`#1e1e1e`, `#ffffff`) were inherited from the system theme so do not match either of the 2 GNOME palettes for ptyxis (GNOME and GNOME Legacy)

The palette [gnome-fedora.palette](custom-palettes/gnome-fedora.palette) will replicate the old Fedora gnome-terminal look, it should be placed or softlinked in the directory `palettes`

