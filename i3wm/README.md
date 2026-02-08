# i3 Window Manager

## Installation

## Quick Start

- `mkdir -p ~/.config/i3 && mkdir -p ~/.config/i3status && mkdir -p ~/bin`
- `cp i3wm/i3/config ~/.config/i3/config && cp i3wm/i3status/config
  ~/.config/i3status/config && cp -a i3wm/bin/. ~/bin`
- If no greeter or login manager:
    - `echo 'exec i3' >> ~/.xinitrc`
    - `startx`

## Configuration

Subdirectories `i3/` and `i3status/` are located in `~/.config`. A good place to
put the helper scripts from `bin/` is in the home directory `~/bin`. This could
then be added the the user's `$PATH` variable.

## GTK Settings

`lxappearance` used to be a good app to configure gtk settings, but the files
it sets are now ignored. An actual daemon is required to be running to provide
settings to GTK apps and `xsettingsd` is a good choice. GTK theme and icons, and
settings like font rendering or cursor blinking are done here

`xfsettingsd` (xfce settings daemon) can be used but it will also set all the
xfce keyboard shortcuts and clash with our desired i3 keyboard shortcuts

## Use

- If no desktop environment and starting i3 manually, start X session with
  `startx` and execute i3 by appending `exec i3` to `~/.xinitrc`.
- Otherwise select from your login manager.

## Future

- Installation instructions, including a list of packages to install. Eg. i3
  itself, i3lock, i3status, dmenu, rofi, etc.

- Make import scripts to import config files and the util scripts in `bin/`.
    - Any custom made lockscreen images too & an example wallpaper?

- Make a separate config file for custom use, and a simpler config file for more
  basic use with no dependencies on helper scripts etc.

- Fix keyboard shortcuts around closing programs / exiting to be compatible with
  default keybinds.

- Remove dependencies on `bin/` scripts if possible.

