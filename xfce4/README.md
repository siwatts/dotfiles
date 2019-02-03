# XFCE

## Steps

1. Install and start xfce4 to generate default panel and other settings.
1. Run [set-xfce.sh](set-xfce.sh) for simple configuration and xfce4-terminal.
1. Terminate xfce4 session by logging out / rebooting.
1. Log in to tty or alternate desktop environment.
1. Run [configure-whiskermenu.sh](configure-whiskermenu.sh) to configure whiskermenu(s).
1. Run [diff-keyboard-shortcuts.sh](diff-keyboard-shortcuts.sh) to set keyboard
   shortcuts by manually importing into xml file.


The script [set-xfce.sh](set-xfce.sh) configures xfce without the need to modify
these files. Some files are provided in this repository for reference (from a
Fedora 27 system 09/18).

Alternatively, diff all configuration files instead of just the keyboard
shortcuts with [diff-xfce.sh](diff-xfce.sh), though files may differ as snapshot
of configuration files is provided as a reference from an older install (Fedora
27 09/18).  [set-xfce.sh](set-xfce.sh) will set only those settings which
normally differ from default.

## Configuration

`xfconf-query` can configure xfce on the fly.  A script that configures xfce
using `xfconf-query` is provided and can be run from this directory with
[set-xfce.sh](set-xfce.sh). This does not set keyboard shortcuts. The script
copies over the xfce4-terminal [terminalrc](terminal/terminalrc) file if found.

[configure-whiskermenu.sh](configure-whiskermenu.sh) changes some common
whiskermenu settings by altering these lines of the configuration file using
`sed`.

[diff-keyboard-shortcuts.sh](diff-keyboard-shortcuts.sh) diffs the keyboard
shortcut xml file using `vim -d`. Or you can diff more configuration files using
[diff-xfce.sh](diff-xfce.sh).

Using `xfconf-query`:
- List channels
    - `xfconf-query`
- List properties under a parent
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands -l`
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom -l`
- List properties with their values
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands -l -v`
- List individual property value
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/Print`
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'f`
- Set individual property
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'f -s firefox`
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'f -s 'firefox --private-browsing'`
- Create new property with type string/int/bool
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'f -n -t string -s 'firefox --private-browsing'`
    - This overwrites value if this property already exists
- If property already exists it must first be removed with `reset` before being
  replaced
    - For keyboard shortcuts, both the `/commands/custom` and `/xfwm4/custom`
      entries must be removed.
    - `xfconf-query -r -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'f`
    - `xfconf-query --reset -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'f`
    - `xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'f -n -t string -s 'firefox --private-browsing'`
    - `-r`/`--reset`, and `-n`/`--create` are interchangable.
    - This doesn't seem to work reliably for keyboard shortcuts.

## Configuration Files

The configuration files for xfce4 are located mainly in a couple of places:
- `~/.config/xfce4/`.
- `~/.local/share/xfce4/`.

The script [set-xfce.sh](set-xfce.sh) configures xfce without the need to modify
these files. Some files are provided in this repository for reference (from a
Fedora 27 system 09/18).

Files in this directory are relative to `~/.config/xfce4/`.

When changing these config files, an xfce session must not be running or the
changes will be overwritten on logout. Try syncing these files in a tty while
not logged in if not using the script calling `xfconf-query`.

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

Xfwm4 can be replaced with openbox [as detailed here](../openbox/README.md).

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

Replace xscreensaver with light-locker:
- `sudo dnf install light-locker` (or your package manager here).
- `xfconf-query -c xfce4-session -p /general/LockCommand -s "dm-tool lock" --create -t string`
- Can further configure in Power Manager, Security tab.
- Requires a reboot to fully take effect. Should not be able to switch tty to
  get back to active desktop after a reboot.
- Lock command for `xflock4` is defined in `/usr/bin/xflock4`. The file reads
  from the xfce setting set by `xfconf-query` above but you can also manually
  set it here (append `light-locker-command --lock` or `dm-tool lock` to the
  list of commands to try)

## Future

- Using compton, and a config file.

