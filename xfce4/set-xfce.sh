#!/bin/bash
# - 02/09/2018 - SW -
# - 20/05/2025 - SW -
# Configure xfce settings using xfconf-query, and import terminal settings:

# First import xfce4-terminal config:
# Terminalrc file is not used anymore, but it seems to work to seed initial settings
if [ ! -d ~/.config/xfce4/terminal ]; then
    # Make it
    mkdir -p ~/.config/xfce4/terminal
fi
if [ -f terminal/terminalrc ]; then
    if [ -f ~/.config/xfce4/terminal/terminalrc ]; then
        # There is already a terminal config file, diff it.
        vim -d ~/.config/xfce4/terminal/terminalrc terminal/terminalrc
        # Or backup and replace
    else
        # None, so copy ours.
        cp terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
        echo "Imported xfce4-terminal settings. Close all running instances to take effect."
    fi
else
    echo "Warning: Could not find dotfiles xfce4-terminal 'terminalrc' file. Please run from dotfiles 'xfce4' directory to import this."
fi

echo "Configuring xfce with 'xfconf-query'..."

# Thunar 1440 (last rough size used on 1440 screen)
xfconf-query --create -c 'thunar' -p '/last-window-width' --type 'int' --set '1080'
xfconf-query --create -c 'thunar' -p '/last-window-height' --type 'int' --set '810'
xfconf-query --create -c 'thunar' -p '/last-window-maximized' --type 'bool' --set 'false'

## Thunar 1080
#xfconf-query --create -c 'thunar' -p '/last-window-width' --type 'int' --set '870'
#xfconf-query --create -c 'thunar' -p '/last-window-height' --type 'int' --set '620'
#xfconf-query --create -c 'thunar' -p '/last-window-maximized' --type 'bool' --set 'false'

# GTK theme
#xfconf-query --create -c 'xsettings' -p '/Net/ThemeName' --type 'string' --set 'Adwaita'
#xfconf-query --create -c 'xsettings' -p '/Net/ThemeName' --type 'string' --set 'Greybird'
#xfconf-query --create -c 'xfwm4' -p '/general/theme' --type 'string' --set 'Mint-Y-Dark-Blue'
#xfconf-query --create -c 'xfwm4' -p '/general/theme' --type 'string' --set 'Greybird-dark-accessibility'
xfconf-query --create -c 'xsettings' -p '/Net/IconThemeName' --type 'string' --set 'elementary-xfce-dark'

# Fonts 1440
xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 11'
xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono 11'
xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'rgb'
xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 10'

## Fonts 1080
#xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 10'
#xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono 10'
#xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'rgb'
#xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 9'

## Fonts 768
#xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 9'
#xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono 9'
#xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'rgb'
#xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 8'

# TODO: Add HTPC fonts (even larger)

# Xfwm4
xfconf-query --create -c 'xfwm4' -p '/general/button_layout' --type 'string' --set 'O|HMC'
xfconf-query --create -c 'xfwm4' -p '/general/wrap_windows' --type 'bool' --set 'false'
xfconf-query --create -c 'xfwm4' -p '/general/cycle_tabwin_mode' --type 'int' --set '1'
xfconf-query --create -c 'xfwm4' -p '/general/cycle_draw_frame' --type 'bool' --set 'false'
xfconf-query --create -c 'xfwm4' -p '/general/show_dock_shadow' --type 'bool' --set 'false'

# Notifications
xfconf-query --create -c 'xfce4-notifyd' -p '/date-time-custom-format' --type 'string' --set '%a %H:%M:%S'
xfconf-query --create -c 'xfce4-notifyd' -p '/theme' --type 'string' --set 'Smoke'
xfconf-query --create -c 'xfce4-notifyd' -p '/initial-opacity' --type 'double' --set '1'
xfconf-query --create -c 'xfce4-notifyd' -p '/expire-timeout' --type 'int' --set '10'
xfconf-query --create -c 'xfce4-notifyd' -p '/show-notifications-on' --type 'string' --set 'primary-monitor'

# Cursor blink!
xfconf-query --create -c 'xsettings' -p '/Net/CursorBlink' --type 'bool' --set 'false'

# Thunar
xfconf-query --create -c 'thunar' -p '/misc-single-click' --type 'bool' --set 'false'
xfconf-query --create -c 'thunar' -p '/misc-show-delete-action' --type 'bool' --set 'true'

# Screen Power
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/blank-on-ac' --type 'int' --set '30'
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/dpms-on-ac-sleep' --type 'uint' --set '31'
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/dpms-on-ac-off' --type 'uint' --set '32'

# Screensaver
# /saver/mode?
xfconf-query --create -c 'xfce4-screensaver' -p '/saver/mode' --type 'int' --set '2'
xfconf-query --create -c 'xfce4-screensaver' -p '/saver/themes/list' --type 'string' --set 'screensavers-xfce-floaters'
xfconf-query --create -c 'xfce4-screensaver' -p '/saver/idle-activation/delay' --type 'int' --set '15'
xfconf-query --create -c 'xfce4-screensaver' -p '/saver/fullscreen-inhibit' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-screensaver' -p '/lock/saver-activation/delay' --type 'int' --set '1'

# Default window placement size trigger
# Centre all new windows no matter the size
xfconf-query --create -c 'xfwm4' -p '/general/placement_ratio' --type 'int' --set '100'
# Default value is 20, to restore smart placement for windows
# xfconf-query --create -c 'xfwm4' -p '/general/placement_ratio' --type 'int' --set '20'

# Experimental, try setting keyboard shortcuts
# This did not always work before
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>f' --type 'string' --set 'firefox --private-window %u'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>f/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>w' --type 'string' --set 'exo-open --launch WebBrowser'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>w/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>e' --type 'string' --set 'thunar'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>e/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>g' --type 'string' --set 'gvim'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>g/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary>apostrophe' --type 'string' --set 'xfce4-terminal --drop-down'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary>apostrophe/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>t' --type 'string' --set 'exo-open --launch TerminalEmulator'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>t/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>t' --type 'string' --set 'exo-open --launch TerminalEmulator'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>t/startup-notify' --type 'bool' --set 'true'

echo "Configuration complete."

