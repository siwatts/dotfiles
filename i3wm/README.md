# i3 Window Manager

## Installation

## Configuration

Subdirectories `i3/` and `i3status/` are located in `~/.config`. A good place to
put the helper scripts from `bin/` is in the home directory `~/bin`. This could
then be added the the user's `$PATH` variable.

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

