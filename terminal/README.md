# About

Terminal configuration

**Note:** Soft-links assume dotfiles directory is at `~/repos/dotfiles/`

# xfce4-terminal

The default terminal for Xfce desktop

## Config

Former config location, still works to seed initial settings but any changes will be written to xfce settings not this file:

- Location: `~/.config/xfce4/terminal/terminalrc`

```sh
mkdir -p ~/.config/xfce4/terminal
cp -a ~/repos/dotfiles/xfce4/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
```

## Colours

- Location: `~/.local/share/xfce4/terminal/colorschemes/`
- Soft-link script: `terminal/sync-xfce4-terminal-themes.sh`

# URxvt / XTerm

## Config

- Location: `~/.Xresources`
- `~/.Xresources` file is usually loaded by `~/.xinitrc` containing the line `xrdb -merge ~/.Xresources`
- This command can be run at any time to merge in changes to the `.Xresources` file
- Short form `xrdb -m ~/.Xresources`
- Load and replace instead `xrdb -load ~/.Xresources`

```sh
ln -s ~/repos/dotfiles/terminal/Xresources ~/.Xresources
echo 'xrdb -merge ~/.Xresources' >> ~/.xinitrc
```

# lxterminal

Simple gtk terminal, used by LXDE desktop

## Config

```sh
mkdir -p ~/.config/lxterminal
ln -s ~/repos/dotfiles/terminal/lxterminal/lxterminal.conf ~/.config/lxterminal/lxterminal.conf
```

# qterminal

Simple QT terminal, used by LXQT desktop

## Config

```sh
mkdir -p ~/.config/qterminal.org
ln -s ~/repos/dotfiles/terminal/qterminal/qterminal.ini ~/.config/qterminal.org/qterminal.ini
```

# kitty

## Config

- Location: `~/.config/kitty/kitty.conf`

```sh
mkdir -p ~/.config/kitty
ln -s ~/repos/dotfiles/terminal/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/repos/dotfiles/terminal/kitty/clear-cursor.conf ~/.config/kitty/clear-cursor.conf
```

## Colours

`kitten themes`

# alacritty

## Config

- Location: `~/.config/alacritty/alacritty.toml`

```sh
mkdir -p ~/.config/alacritty
ln -s ~/repos/dotfiles/terminal/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```

# wezterm

## Config

- Location: `~/.wezterm.lua`

```sh
ln -s ~/repos/dotfiles/terminal/wezterm/wezterm.lua ~/.wezterm.lua
```

# Colours

Built-in, see [docs](https://wezterm.org/colorschemes/index.html)

