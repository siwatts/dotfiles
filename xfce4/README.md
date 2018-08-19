# XFCE

## Configuration Files

The configuration files for xfce4 are located mainly in a couple of places:
- `~/.config/xfce4/`.
- `~/.local/share/xfce4/`.

Files in this directory are relative to `~/.config/xfce4/`.

When changing these config files, an xfce session must not be running or the
changes will be overwritten on logout. Try syncing these files in a tty while
not logged in.

## Xfce4-terminal

- Config location: `~/.config/xfce4/terminal/terminalrc`.

- Themes location: `~/.local/share/xfce4/terminal/colorschemes/`.

- Quake style dropdown terminal: `xfce4-terminal --drop-down`.

- Keyboard shortcuts:
    - New tab: `Ctrl+Shift+T`.
    - Next/prev tab: `Ctrl+PgDn/PgUp`.
    - Scroll down/up: `Shift+PgDn/PgUp`.

## Panel

Keep `xfce4-panel` behind full screen applications.
- Do this automatically using [panel_to_desktop.sh](../bin/panel_to_desktop.sh):
    - Add an entry to `Session and Startup` calling this script.
    - The script assumes a desktop setup with 2 panels that you want to hide
      (one per monitor for example). If this is not the case remove the
      reference to the 2nd panel.
- `sudo dnf install -y wmctrl`
- `wmctrl -l | grep "xfce4-panel$"`
- `wmctrl -i -r <hexadecimal ID> -b add,below`

You can display the output of arbitrary scripts using the Generic Monitor
plugin `xfce4-genmon-plugin`.
- Display volume percentage of primary output sink:
    - [print_vol.sh](../bin/print_vol.sh).
- Display datetime (to combine with volume, for 2nd monitor, or to customise
  font etc.)
    - [panelclock.sh](../bin/panelclock.sh).

## Other

Change xfce appearance theme with bash:
- `xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Darker-solid"`
- Set xfce theme depending on time of day using crontab and shell scripts in
  [misc/set_theme](../misc/set_theme):
    - Copy `.sh` scripts to `~/bin`
    - Append `crontab.txt` contents using `crontab -e`

- Change volume with keyboard. `Keyboard`, `Application Shortcuts`:
    - `pactl set-sink-volume 0 +5%`
    - `pactl set-sink-volume 0 -5%`
    - `pactl set-sink-mute 0 toggle`

## Future

- How to replace `xscreensaver` with `light-locker`.
- Using compton, and a config file.
- Using Openbox as a window manager, and config.

