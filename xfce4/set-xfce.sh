#!/bin/bash
# - 02/09/2018 - SW -
# - 20/05/2025 - SW -
# Configure xfce settings using xfconf-query, and import terminal settings:

# First import xfce4-terminal config:
# Terminalrc file is not used anymore, but it seems to work to seed initial settings
if [ -f terminal/terminalrc ]; then
    if [ ! -d ~/.config/xfce4/terminal ]; then
        # Make dir.
        mkdir -p ~/.config/xfce4/terminal
    fi
    echo "Importing xfce4-terminal config file..."
    if [ -f ~/.config/xfce4/terminal/terminalrc ]; then
        # There is already a terminal config file, diff it.
        echo "User already has a terminal config file, opening in vimdiff for comparison..."
        read -r -p 'PRESS ENTER TO CONTINUE...' response
        vim -d ~/.config/xfce4/terminal/terminalrc terminal/terminalrc
    else
        # None, so copy ours.
        cp terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
        echo "Imported xfce4-terminal config file. Close all running instances to reload."
    fi
else
    echo "Warning: Could not find dotfiles xfce4-terminal 'terminalrc' file. Please run from dotfiles 'xfce4' directory to import this."
fi

# For helper script keyboard shortcuts
BIN_PATH="/home/${USER}/bin"

echo "Configuring xfce with 'xfconf-query'..."

# TODO: Choose screensize by user prompt or try detecting it

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
xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 12'
xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono Text 12'
xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'rgb'
xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 11'

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
## And make thunar slightly smaller for small screen, default is 100% and 24px icons
#xfconf-query --create -c 'thunar' -p '/last-icon-view-zoom-level' --type 'string' --set 'THUNAR_ZOOM_LEVEL_75_PERCENT'
#xfconf-query --create -c 'thunar' -p '/shortcuts-icon-size' --type 'string' --set 'THUNAR_ICON_SIZE_16'

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
xfconf-query --create -c 'thunar' -p '/misc-thumbnail-mode' --type 'string' --set 'THUNAR_THUMBNAIL_MODE_ALWAYS'

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
# Default value is 20, to restore smart placement for some windows
# xfconf-query --create -c 'xfwm4' -p '/general/placement_ratio' --type 'int' --set '20'

# Keyboard shortcuts
# This did not always work before, but seems fixed as of xfce 4.18 with <Primary> used for Ctrl key
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>w' --type 'string' --set 'exo-open --launch WebBrowser'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>w/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>f' --type 'string' --set 'firefox --private-window'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>f/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>e' --type 'string' --set 'thunar'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>e/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>g' --type 'string' --set 'gvim'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>g/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>t' --type 'string' --set 'exo-open --launch TerminalEmulator'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>t/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>t' --type 'string' --set 'exo-open --launch TerminalEmulator'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>t/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary>apostrophe' --type 'string' --set 'xfce4-terminal --drop-down'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary>apostrophe/startup-notify' --type 'bool' --set 'true'

#/commands/custom/<Super>r/XF86AudioMedia             pragha
#/commands/custom/<Super>r/XF86AudioNext              pragha --next
#/commands/custom/<Super>r/XF86AudioPlay              pragha --pause
#/commands/custom/<Super>r/XF86AudioPrev              pragha --prev
#/commands/custom/<Super>r/XF86Calendar               orage
#/commands/custom/<Super>r/XF86Memo                   xfce4-notes

xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Alt>F1' --type 'string' --set 'xfce4-popup-applicationsmenu'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Alt>F2' --type 'string' --set 'xfce4-appfinder --collapsed'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Alt>F2/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Alt>F3' --type 'string' --set 'xfce4-appfinder'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Alt>F3/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/HomePage' --type 'string' --set 'exo-open --launch WebBrowser'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/HomePage/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>Delete' --type 'string' --set 'xfce4-session-logout'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>Escape' --type 'string' --set 'xkill'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>f' --type 'string' --set 'thunar'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>f/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>l' --type 'string' --set 'xflock4'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Alt>l' --type 'string' --set 'xflock4'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary>Escape' --type 'string' --set 'xfdesktop --menu'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Shift>Escape' --type 'string' --set 'xfce4-taskmanager'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary><Shift>Escape/startup-notify' --type 'bool' --set 'true'

# Printscreen (flameshot)
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/Print' --type 'string' --set 'flameshot gui'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Shift>Print' --type 'string' --set 'flameshot launcher'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Primary>Print' --type 'string' --set 'flameshot screen'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Alt>Print' --type 'string' --set 'xfce4-screenshooter -w'

# Scripts (~/bin)
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>Home' --type 'string' --set "${BIN_PATH}/centre-window.sh"
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Shift><Super>Home' --type 'string' --set 'bash -c "'"${BIN_PATH}/resize-window-for-reading.sh && ${BIN_PATH}"'/centre-window.sh"'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Shift><Super>plus' --type 'string' --set "${BIN_PATH}/monitor-adjust-up.sh 5"
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Shift><Super>underscore' --type 'string' --set "${BIN_PATH}/monitor-adjust-down.sh 5"
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>equal' --type 'string' --set "${BIN_PATH}/monitor-adjust-up.sh 10"
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>minus' --type 'string' --set "${BIN_PATH}/monitor-adjust-down.sh 10"
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>0' --type 'string' --set "${BIN_PATH}/monitor-current.sh"

xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>bracketleft' --type 'string' --set 'pactl set-sink-volume 0 -5%'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>bracketright' --type 'string' --set 'pactl set-sink-volume 0 +5%'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>BackSpace' --type 'string' --set 'pactl set-sink-mute 0 toggle'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>d' --type 'string' --set 'xfdashboard'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>grave' --type 'string' --set 'xfce4-terminal --drop-down'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>grave/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/Super_L' --type 'string' --set 'xfce4-popup-whiskermenu'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>p' --type 'string' --set 'xfce4-display-settings --minimal'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r' --type 'string' --set 'xfce4-appfinder -c'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r/XF86Calculator' --type 'string' --set 'galculator'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r/XF86Calculator/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r/XF86Explorer' --type 'string' --set 'Thunar'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r/XF86Explorer/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r/XF86Terminal' --type 'string' --set 'xfce4-terminal'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Super>r/XF86Terminal/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/XF86Display' --type 'string' --set 'xfce4-display-settings --minimal'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/XF86LogOff' --type 'string' --set 'xfce4-session-logout'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/XF86Mail' --type 'string' --set 'exo-open --launch MailReader'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/XF86Mail/startup-notify' --type 'bool' --set 'true'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/XF86WWW' --type 'string' --set 'exo-open --launch WebBrowser'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/XF86WWW/startup-notify' --type 'bool' --set 'true'

# Window Manager Keyboard shortcuts
# These are different, there cannot be duplicates as they are assigned to actual xfce functions
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>Insert' --type 'string' --set 'add_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>Delete' --type 'string' --set 'del_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F4' --type 'string' --set 'close_window_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F6' --type 'string' --set 'stick_window_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F7' --type 'string' --set 'move_window_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F8' --type 'string' --set 'resize_window_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F9' --type 'string' --set 'hide_window_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F10' --type 'string' --set 'maximize_window_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F11' --type 'string' --set 'fullscreen_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>F12' --type 'string' --set 'above_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>Tab' --type 'string' --set 'cycle_windows_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt><Shift>Tab' --type 'string' --set 'cycle_reverse_windows_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Alt>space' --type 'string' --set 'popup_menu_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>d' --type 'string' --set 'show_desktop_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>Up' --type 'string' --set 'up_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>Down' --type 'string' --set 'down_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>Left' --type 'string' --set 'left_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>Right' --type 'string' --set 'right_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Shift><Alt>Left' --type 'string' --set 'move_window_left_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Shift><Alt>Right' --type 'string' --set 'move_window_right_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>Page_Up' --type 'string' --set 'previous_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>Page_Down' --type 'string' --set 'next_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>End' --type 'string' --set 'move_window_next_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>Home' --type 'string' --set 'move_window_prev_workspace_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_1' --type 'string' --set 'move_window_workspace_1_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_2' --type 'string' --set 'move_window_workspace_2_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_3' --type 'string' --set 'move_window_workspace_3_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_4' --type 'string' --set 'move_window_workspace_4_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_5' --type 'string' --set 'move_window_workspace_5_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_6' --type 'string' --set 'move_window_workspace_6_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_7' --type 'string' --set 'move_window_workspace_7_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_8' --type 'string' --set 'move_window_workspace_8_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary><Alt>KP_9' --type 'string' --set 'move_window_workspace_9_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F1' --type 'string' --set 'workspace_1_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F2' --type 'string' --set 'workspace_2_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F3' --type 'string' --set 'workspace_3_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F4' --type 'string' --set 'workspace_4_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F5' --type 'string' --set 'workspace_5_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F6' --type 'string' --set 'workspace_6_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F7' --type 'string' --set 'workspace_7_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F8' --type 'string' --set 'workspace_8_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F9' --type 'string' --set 'workspace_9_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F10' --type 'string' --set 'workspace_10_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F11' --type 'string' --set 'workspace_11_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Primary>F12' --type 'string' --set 'workspace_12_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Shift><Super>Left' --type 'string' --set 'move_window_to_monitor_left_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Shift><Super>Right' --type 'string' --set 'move_window_to_monitor_right_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Shift><Alt>Page_Down' --type 'string' --set 'lower_window_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Shift><Alt>Page_Up' --type 'string' --set 'raise_window_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_Down' --type 'string' --set 'tile_down_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_End' --type 'string' --set 'tile_down_left_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_Home' --type 'string' --set 'tile_up_left_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_Left' --type 'string' --set 'tile_left_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_Next' --type 'string' --set 'tile_down_right_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_Page_Up' --type 'string' --set 'tile_up_right_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_Right' --type 'string' --set 'tile_right_key'
#xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>KP_Up' --type 'string' --set 'tile_up_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>Left' --type 'string' --set 'tile_left_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>Right' --type 'string' --set 'tile_right_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>Up' --type 'string' --set 'tile_up_key'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/xfwm4/custom/<Super>Down' --type 'string' --set 'tile_down_key'

echo "Configuration complete."

