# About

Converting a Fedora 41 Workstation (GNOME) install to use Xfce

# Install

```bash
sudo dnf install -y @xfce-desktop-environment
```

Other packages (can use dnf dragora or CLI):

- General
    - `vim vim-X11 git gitk tmux htop`
- Xfce Desktop
    - Applications for the Xfce Desktop
        - `atril`
        - `galculator`
        - `mousepad`
        - `ristretto`
- Settings
    - `lightdm-gtk-greeter-settings`
- GTK Themes and Icons
    - `bluebird-gtk3-theme`
    - `bluebird-gtk2-theme`
    - `bluebird-xfwm4-theme`
    - `elementary-xfce-icon-theme`
    - `numix-gtk-theme`
    - `numix-icon-theme`
    - `numix-icon-circle`
    - `numix-icon-square`
- For centre window script
    - `sudo dnf install -y xdpyinfo xdotool`
- Panel plugins
    - `xfce4-whiskermenu-plugin`
- Media
    - `smplayer`
- Misc
    - `flameshot`, screenshot util

# Settings

- Session & Startup
    - Disable `dnfdragora-updater`
    - Enable `Secret Storage Service (GNOME Keyring: Secret Service)`
    - Both of these can be done by copying the files in `autostart/` to `~/.config/autostart`, this is what the GUI creates
- Appearance
    - Change font, 'Sans 11' (for 1440 monitor)
    - 'Cantarell 11' looks better, it's what GNOME uses but they are moving away from it so it may not be around in future
    - Monospace font to preferred font ('Source Code Pro Regular' or 'Liberation Mono Regular' size 11)
    - RGB subpixel enable
    - GTK theme and xfwm4 theme to preferred theme
        - Adwaita, Adwaita Dark, Numix, Greybird, Greybird Dark all good
        - 'Greybird accessibility' xfwm4 themes good on 1440 screen for larger buttons, but not necessary, "Default" xfwm4 also good even for themes like Greybird as it matches their colour but is large and usable
    - Icon theme 'elementary Xfce dark'
- Window Manager
    - Title font, 'Sans Bold 10' or 11, or Cantarell bold to match UI if chosen earlier
    - Remove 'Shade'
- Window Manager Tweaks
    - Cycling
        - Draw frame around windows, disable
        - Raise windows while cycling, disable
        - Cycle through windows in a list, enable
    - Compositor
        - Show shadows under dock windows, disable
            - **Important if using top panel, otherwise window title bars get shadows on them and are hard to read**
- Notifications
    - Set a more legible theme (Smoke or Retro). Opacity to 100%
    - Show on primary monitor
    - Top centre may be better on 1440 screen than top right, but it is offset slightly

# Panel

- Delete 2nd panel
- Move 1st panel to bottom of screen
    - Add launchers: Firefox, `firefox --private-window`, Terminal, Files, GVim
    - Or add `Places` instead of Thunar
    - Thickness 26 by default, on 1440 30 or 32 is good
        - Larger: 36, icons 22
    - Panel appearance, Icons, Adjust size automatically default is 16, set to 20 (for panel 30), or adjust size automatically (this is larger than 20)
    - Status Tray Plugin, Icons, Match above icon size settings
- Clock, display Time only, font match UI, Custom format: `%a %d/%m/%y %R` or `%a %d %b %R` like GNOME for cleaner look
- Remove 'Action Buttons' from end of panel
- Add 'Show Desktop' to end of panel
- Further customisation possible with other plugins but the basic panel is very usable
- Change Window Buttons
    - Group windows by application, disable
    - Sorting order: 'Timestamp', or 'None allow drag and drop'
    - Show flat buttons, enable (if this clashes with GTK theme)
- Background to `#151515` or the dark purple above black, if switching GTK themes and panel becomes too light
- Genmon
    - Monitor brightness display in panel:
        - Label `Scr: `, or a brightness emoji like `🔆`
        - `bash -c "sed -n 's/$/%/p' /usr/local/bin/monitor-brightness.txt || echo 'XX%'"`
        - This is like `cat /usr/local/bin/monitor-brightness.txt`, but adds a trailing `%` for spacing and formatting
        - If the file is missing (which can happen if genmon refreshes at the same time the script is running) a clean fallback "XX%" is returned instead of a sed error message
        - Period 15s
    - Volume % in panel:
        - No label
        - Command: `bash -c "pactl get-sink-volume 0 | head -n1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1%,'"`
        - Period 15s
- TODO: Add panel layout here
- CPU Graph
    - Colour 1: `#008000`
    - Colour 2: Red 2nd up from bottom
    - Mode: Normal
    - Colour mode: Gradient
    - Update Slow ~1s, or Normal ~750ms
    - Show frame, enable
    - Show border, disable
    - Width 40, or 50
- System Load Monitor
    - Update interval 1500ms or 1000ms
    - Swap monitor label to `swp`
    - CPU monitor colour: `#008000`
    - Memory monitor colour: Blue at bottom
    - Network monitor colour: Red at bottom
    - Swap monitor colour: Yellow at bottom
- Workspace switcher
    - Switch to 2 row view
- Add Action Buttons before show desktop at end of panel
    - Switch to custom label, with hostname of system

# WhiskerMenu

- General
    - Show as icons
    - App and Category icon sizes: Normal
    - Width 800
    - Height 1000 (or 800 with Category icon size, Small)
- Appearance
    - Profile on bottom (moves buttons to bottom)
    - Others off
    - Icon and Title
- Set keyboard shortcut Super to open whisker menu, xfce has resolved this issue now so other Super+X shortcuts aren't affected
    - Command `xfce4-popup-whiskermenu`
    - But must use 'Alt' for window grab key in Window Manager Tweaks -> Accessibility, otherwise it breaks Super key shortcuts
- Behaviour
    - Switch categories by hovering, enable

# Keyboard

For GUI program shortcuts, set 'Use startup notification' enabled

- Set monitor brightness keyboard shortcuts (see dotfiles)
- `Super+W` to `exo-open --launch WebBrowser` (Firefox)
- `Super+F` to `firefox --private-window`
- `Super+G` to `gvim`
- `Super+T` to `exo-open --launch TerminalEmulator` (xfce4-terminal)
- `Super+Home` to `~/bin/centre-window.sh`
- `Super+Shift+Home` to `bash -c "~/bin/resize-window-for-reading.sh && ~/bin/centre-window.sh"`
- `Super` to WhiskerMenu: `xfce4-popup-whiskermenu`

If no media keys on keyboard, add some volume control keyboard shortcuts e.g. `Super`+`[`/`]`, `BKSPC` to toggle mute

```
pactl set-sink-volume 0 -5%
pactl set-sink-volume 0 +5%
pactl set-sink-mute 0 toggle
```

# Window Manager Keyboard

These don't currently seem to work

- Move window to left monitor, `Super+Shift+Left`
- Move window to right monitor, `Super+Shift+Right`

# Misc

- Set default programs
    - `.jpg` `.png` to ristretto
    - Videos to mpv (or install Xfce chosen videoplayer, Parole)
    - PDF to Atril
- `xfconf-query -c xsettings -p /Net/CursorBlink -s 'false'`
- Mouse and Touchpad theme to Adwaita
- Desktop Settings
    - Icons -> Single click to activate items, enable

# Screensaver

- Floating Xfce
- 15 minutes
- Inhibit screensaver for fullscreen applications, enable
- Lock Screen after the screensaver is active for 1 minute

## XScreensaver

Replace xfce4-screensaver with xscreensaver (optional)

- `sudo dnf install xscreensaver xscreensaver-extras -y`
- Run xscreensaver settings program (from menu) or `xscreensaver-demo` to configure settings
- Session & Startup
    - Disable xfce4-screensaver process from starting automatically on login by unchecking
    - Add xscreensaver process automatically on login, process `xscreensaver -nosplash`
        - Or enable the one that was added automatically? `/usr/libexec/xscreensaver-autostart`

# Power Management

- Display power management, 30 min

# Caps Lock Key Map

*Optional*

Set the Caps Lock key to an additional ESC key, using xkbmap

- `setxkbmap -option caps:escape_shifted_capslock`
- Other options
    - `caps:swapescape`
        - Just swap Caps and ESC
    - `caps:escape`
        - Just make Caps an additional ESC, without retaining Caps Lock functionality on Shift+Caps

Persist on reboot:
- Session and Startup
- Add application
- Name:
    - `Caps to Esc`
- Description:
    - `Set Caps Lock key to an additional ESC, and Shift+Caps to function as Caps Lock`
- Command:
    - `setxkbmap -option caps:escape_shifted_capslock`
- Trigger:
    - on login

Alternative:
- You can use Caps as an extra Ctrl when held as a modifier key, and also use `xcape` to remap single presses to ESC
    - `setxkbmap -option 'caps:ctrl_modifier'`
    - `xcape -e 'Caps_Lock=Escape'`

It is also possible to make this permanent using `localectl` instead e.g. **for US keyboard layout** `localectl set-x11-keymap us "" "" caps:swapescape`, investigate how this would work for us. (This writes a config file in `/etc/X11/xorg.conf.d/`, other options available here `/usr/share/X11/xkb/rules/base.lst`)

# Workspace Switching

Keyboard shortcuts for workspace switching are in Window Manager, but can only accept 1 value and certain key combinations like `Super+1` do not work

We can switch using `xdotool` and overload with multiple shortcuts using commands like `xdotool set_desktop 0` for 1st workspace and so on

Some ideas for workspace N:

- `Super+N`
- `Super+KP_N`
- `Ctrl+Alt+1`
- `Ctrl+Alt+KP_1`
    - Requires unbind from Window Manager, as this is already "send window to workspace 1", replace it with `Shift+Alt+KP_1`

# Misc

Fedora 41 -> 42 GNOME removed X11, thus also removing ability for GNOME gdm login screen to launch an Xfce session if this was added afterwards to a Workstation install

Switch to lightdm gtk greeter to be able to log into either GNOME or Xfce:

```bash
sudo dnf in lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings -y
sudo systemctl enable lightdm --force
sudo systemctl disable gdm
```

# Gaming

Tested with Fedora 42, RPM Fusion Steam, game Insurgency Sandstorm

- Disable xfwm4 compositing or there is very bad input lag
    - May be an alternate compositor we can use more suited to gaming? (picom?)
- Runs very fast and smooth but with screen tearing
- Enabling in game vsync adds some input lag similar to Windows, not preferred solution
- Using xrandr tearfree works to remove tearing without adding much lag. This is the preferred solution
    - Test this with `xrandr --output DISPLAY --set TearFree on` where `DISPLAY` is the monitor name (get this with `xrandr -q`)
- Make this permanent with the following config file (example for AMD graphics)

`/etc/X11/xorg.conf.d/20-amdgpu.conf`
```
Section "OutputClass"
    Identifier "AMD"
    MatchDriver "amdgpu"
    Driver "amdgpu"
    Option "TearFree" "true"
EndSection
```

# TODO

- Investigate tearing
    - Seemed to resolve itself after logging out and back in, may auto detect hardware now?
    - Disable compositing?
    - Compton?
    - Intel (or GPU) tear free config file
    - Vsync?
- Set up screenshot shortcuts
- Other keyboard shortcuts
- Automate as much of this as possible
    - E.g. cursor blink disable etc. salvage from old dotfiles xfce
    - Should be possible to script everything with `xfconf` or config files `~/.config/xfce4`
- Centre window script cannot handle dual monitors
    - See if it can be modified. Set to centre on single primary monitor if possible
    - `xdpyinfo` reads X11 monitors as one combined monitor, may have to hardcode
- Investigate broken mouse cursor, for loading
- Check workspace keyboard shortcuts
    - They are `Ctrl+Shift+Left`, `Ctrl+Shift+Right`
- Capslock to ESC key
- Check keyring unlock (was triggered once opening dnf-dragora?)
- Keyboard layout
    - UK on 1, UK Extended on 2
    - Sensible shortcut to switch
- Flameshot shortcuts
- Redshift

