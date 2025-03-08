# About

Converting a Fedora 41 Workstation (GNOME) install to use Xfce

# Install

```bash
sudo dnf install -y @xfce-desktop-environment
```

Other packages (can use dnf dragora or CLI):

- Xfce Desktop
    - Applications for the Xfce Desktop
        - `atril`
        - `galculator`
        - `mousepad`
        - `ristretto`
- Misc
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

# Settings

- Session & Startup
    - Disable `dnfdragora-updater`
- Appearance
    - Change font, 'Sans 11' (for 1440 monitor)
    - Monospace font to preferred font ('Source Code Pro Regular' or 'Liberation Mono Regular' size 11)
    - RGB subpixel enable
    - GTK theme and xfwm4 theme to preferred theme
        - Adwaita, Adwaita Dark, Numix, Greybird, Greybird Dark all good
        - 'Greybird accessibility' xfwm4 themes good on 1440 screen for larger buttons, but not necessary, "Default" xfwm4 also good even for themes like Greybird as it matches their colour but is large and usable
    - Icon theme 'elementary Xfce dark'
- Window Manager
    - Title font, 'Sans Bold 10' or 11
    - Remove 'Shade'
- Window Manager Tweaks
    - Cycling
        - Draw frame around windows, disable
        - Raise windows while cycling, disable
        - Cycle through windows in a list, enable
- Notifications
    - Set a more legible theme (Smoke or Retro). Opacity to 100%
    - Show on primary monitor
    - Top centre may be better on 1440 screen than top right, but it is offset slightly

# Panel

- Delete 2nd panel
- Move 1st panel to bottom of screen
    - Add launchers: Firefox, `firefox --private-window`, Terminal, Files, GVim
    - Or add `Places` instead of Thunar
- Clock, display Time only, 'Sans 11', Custom format: `%d/%m/%y %R`
- Remove 'Action Buttons' from end of panel
- Add 'Show Desktop' to end of panel
- Further customisation possible with other plugins but the basic panel is very usable
- Change Window Buttons
    - Group windows by application, disable
    - Sorting order: 'Timestamp', or 'None allow drag and drop'
    - Show flat buttons, enable (if this clashes with GTK theme)
- Background to `#151515` or the dark purple above black, if switching GTK themes and panel becomes too light

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
- `Super` to WhiskerMenu: `xfce4-popup-whiskermenu`

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

# Screensaver

- Floating Xfce
- 15 minutes
- Inhibit screensaver for fullscreen applications, enable
- Lock Screen after the screensaver is active for 1 minute

# Power Management

- Display power management, 30 min

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
- Centre window script cannot handle dual monitors
    - See if it can be modified. Set to centre on single primary monitor if possible
    - `xdpyinfo` reads X11 monitors as one combined monitor, may have to hardcode
- Investigate broken mouse cursor, for loading
- Check workspace keyboard shortcuts
    - They are `Ctrl+Shift+Left`, `Ctrl+Shift+Right`

