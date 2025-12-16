#!/bin/bash
# - 02/09/2018 - SW -
# - 20/05/2025 - SW -
# Configure xfce settings using xfconf-query, and import terminal settings:

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# For helper script keyboard shortcuts
BIN_PATH="/home/${USER}/bin"

echo "Configuring xfce with 'xfconf-query'..."

# Choose screensize + fontsize
echo "Choose screen & font configuration:"
echo "- [1] 1440"
echo "- [2] 1080"
echo "- [3] 1080 HTPC (10ft UI)"
echo "- [4] 768"
echo ""
read -r -p 'Please select a configuration to continue (1-4): ' response
MON_1440=0
MON_1080=0
MON_1080_HTPC=0
MON_768=0
case "$response" in
    1)
        echo "Selected: 1440"
        MON_1440=1
        ;;
    2)
        echo "Selected: 1080"
        MON_1080=1
        ;;
    3)
        echo "Selected: 1080 HTPC (10ft UI)"
        MON_1080_HTPC=1
        ;;
    4)
        echo "Selected: 768"
        MON_768=1
        ;;
    *)
        echo "Invalid choice, aborting"
        exit 1
        ;;
esac

echo "Running xfconf-query commands..."

if [ $MON_1440 -eq 1 ]; then
    # Thunar 1440 (last rough size used on 1440 screen)
    xfconf-query --create -c 'thunar' -p '/last-window-width' --type 'int' --set '1080'
    xfconf-query --create -c 'thunar' -p '/last-window-height' --type 'int' --set '810'
    xfconf-query --create -c 'thunar' -p '/last-window-maximized' --type 'bool' --set 'false'
elif [ $MON_768 -eq 1 ]; then
    # Thunar 768 (laptop)
    xfconf-query --create -c 'thunar' -p '/last-window-width' --type 'int' --set '800'
    xfconf-query --create -c 'thunar' -p '/last-window-height' --type 'int' --set '560'
    xfconf-query --create -c 'thunar' -p '/last-window-maximized' --type 'bool' --set 'false'
else
    # Thunar 1080
    xfconf-query --create -c 'thunar' -p '/last-window-width' --type 'int' --set '870'
    xfconf-query --create -c 'thunar' -p '/last-window-height' --type 'int' --set '620'
    xfconf-query --create -c 'thunar' -p '/last-window-maximized' --type 'bool' --set 'false'
fi

## GTK theme, override below based on screen size
#xfconf-query --create -c 'xsettings' -p '/Net/ThemeName' --type 'string' --set 'Adwaita'
#xfconf-query --create -c 'xfwm4' -p '/general/theme' --type 'string' --set 'Default'
##
## GTK options:
## - Adwaita
## - Adwaita-dark
## - Greybird
## - Greybird-dark
##
## Xfwm4 options:
## - Default
## - Default-hdpi
## - Greybird
## - Greybird-dark
## - Greybird-accessibility
## - Greybird-dark-accessibility
## - Greybird-compact
## - Mint-Y-Dark-Blue

# Icons
xfconf-query --create -c 'xsettings' -p '/Net/IconThemeName' --type 'string' --set 'elementary-xfce'

if [ $MON_1440 -eq 1 ]; then
    # Fonts 1440
    xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 12'
    xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono 13'
    xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'rgb'
    xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 11'
    # Mouse
    xfconf-query --create -c 'xsettings' -p '/Gtk/CursorThemeSize' --type 'int' --set '24'
    # GTK theme
    xfconf-query --create -c 'xsettings' -p '/Net/ThemeName' --type 'string' --set 'Greybird'
    xfconf-query --create -c 'xfwm4' -p '/general/theme' --type 'string' --set 'Mint-Y-Dark-Blue'
elif [ $MON_1080 -eq 1 ]; then
    # Fonts 1080
    xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 11'
    xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono 12'
    xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'rgb'
    xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 10'
    # Mouse
    xfconf-query --create -c 'xsettings' -p '/Gtk/CursorThemeSize' --type 'int' --set '24'
    # GTK theme
    xfconf-query --create -c 'xsettings' -p '/Net/ThemeName' --type 'string' --set 'Greybird'
    xfconf-query --create -c 'xfwm4' -p '/general/theme' --type 'string' --set 'Mint-Y-Dark-Blue'
elif [ $MON_1080_HTPC -eq 1 ]; then
    # Fonts 1080 HTPC 10 ft UI
    xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 14'
    xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono 14'
    # Disable subpixel RGB for 4K TVs because this config is for 1080 output resolution
    xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'none'
    xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 12'
    # Mouse
    xfconf-query --create -c 'xsettings' -p '/Gtk/CursorThemeSize' --type 'int' --set '32'
    # GTK theme
    xfconf-query --create -c 'xsettings' -p '/Net/ThemeName' --type 'string' --set 'Adwaita-dark'
    xfconf-query --create -c 'xfwm4' -p '/general/theme' --type 'string' --set 'Default-hdpi'
elif [ $MON_768 -eq 1 ]; then
    # Fonts 768
    xfconf-query --create -c 'xsettings' -p '/Gtk/FontName' --type 'string' --set 'Noto Sans 10'
    xfconf-query --create -c 'xsettings' -p '/Gtk/MonospaceFontName' --type 'string' --set 'IBM Plex Mono 10'
    xfconf-query --create -c 'xsettings' -p '/Xft/RGBA' --type 'string' --set 'rgb'
    xfconf-query --create -c 'xfwm4' -p '/general/title_font' --type 'string' --set 'Noto Sans Bold 9'
    # And make thunar slightly smaller for small screen, default is 100% and 24px icons
    xfconf-query --create -c 'thunar' -p '/last-icon-view-zoom-level' --type 'string' --set 'THUNAR_ZOOM_LEVEL_75_PERCENT'
    xfconf-query --create -c 'thunar' -p '/shortcuts-icon-size' --type 'string' --set 'THUNAR_ICON_SIZE_16'
    # Mouse
    xfconf-query --create -c 'xsettings' -p '/Gtk/CursorThemeSize' --type 'int' --set '24'
    # GTK theme
    xfconf-query --create -c 'xsettings' -p '/Net/ThemeName' --type 'string' --set 'Greybird-dark'
    xfconf-query --create -c 'xfwm4' -p '/general/theme' --type 'string' --set 'Greybird-dark'
    # Hide window titles on maximise, false by default but true saves some space
    #xfconf-query --create -c 'xfwm4' -p '/general/titleless_maximize' --type 'bool' --set 'true'
fi
xfconf-query --create -c 'xsettings' -p '/Xft/Hinting' --type 'int' --set 1
xfconf-query --create -c 'xsettings' -p '/Xft/HintStyle' --type 'string' --set 'hintslight'

# Xfwm4
xfconf-query --create -c 'xfwm4' -p '/general/button_layout' --type 'string' --set 'O|HMC'
xfconf-query --create -c 'xfwm4' -p '/general/wrap_windows' --type 'bool' --set 'false'
xfconf-query --create -c 'xfwm4' -p '/general/cycle_tabwin_mode' --type 'int' --set '1'
xfconf-query --create -c 'xfwm4' -p '/general/cycle_draw_frame' --type 'bool' --set 'false'
xfconf-query --create -c 'xfwm4' -p '/general/show_dock_shadow' --type 'bool' --set 'false'
# When window gets focus, switch to workspace containing it instead of pulling it to this workspace
xfconf-query --create -c 'xfwm4' -p '/general/activate_action' --type 'string' --set 'switch'

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

# Ristretto Image Viewer
xfconf-query --create -c 'ristretto' -p '/image/wrap' --type 'bool' --set 'false'
xfconf-query --create -c 'ristretto' -p '/window/bgcolor-override' --type 'bool' --set 'true'
xfconf-query --create -c 'ristretto' -p '/window/bgcolor' --type 'double' --set '0.133333' --type 'double' --set '0.133333' --type 'double' --set '0.133333' --type 'double' --set '1.000000'

# Mousepad (uses gsettings instead of xfconf-query)
if command -v gsettings &> /dev/null ; then
    gsettings set org.xfce.mousepad.preferences.view color-scheme 'oblivion'
    gsettings set org.xfce.mousepad.preferences.view show-line-numbers true
    gsettings set org.xfce.mousepad.preferences.view word-wrap true
    gsettings set org.xfce.mousepad.preferences.view auto-indent true
    gsettings set org.xfce.mousepad.preferences.view tab-width 4
    gsettings set org.xfce.mousepad.preferences.view insert-spaces true
    gsettings set org.xfce.mousepad.preferences.view use-default-monospace-font true
else
    echo "WARN: Do not see 'gsettings', unable to configure mousepad"
fi

# Screen Power
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/blank-on-ac' --type 'int' --set '30'
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/dpms-on-ac-sleep' --type 'uint' --set '31'
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/dpms-on-ac-off' --type 'uint' --set '32'
# Laptops
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/dpms-on-battery-sleep' --type 'uint' --set '20'
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/dpms-on-battery-off' --type 'uint' --set '21'
# Laptop action on lid close
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/lid-action-on-ac' --type 'uint' --set '0'
xfconf-query --create -c 'xfce4-power-manager' -p '/xfce4-power-manager/lid-action-on-battery' --type 'uint' --set '0'

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

# Workspace count & names
# By default there are usually 4, make it 10 temporarily so we can rename all 10, then reset back to 4
# Rename all to be "1", "2", ... instead of "Workspace 1", "Workspace 2"...
# This means in future if we make more workspaces dynamically like 5, 6 etc. they are named correctly
# There is a keyboard shortcut for the creation and deletion of workspaces also
xfconf-query --create -c 'xfwm4' -p '/general/workspace_count' --type int --set 10
xfconf-query --create -c 'xfwm4' -p '/general/workspace_names' --type string --set "1" --type string --set "2" --type string --set "3" --type string --set "4" --type string --set "5" --type string --set "6" --type string --set "7" --type string --set "8" --type string --set "9" --type string --set "10"
xfconf-query --create -c 'xfwm4' -p '/general/workspace_count' --type int --set 4

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
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Shift><Super>braceleft' --type 'string' --set 'pactl set-sink-volume 0 -1%'
xfconf-query --create -c 'xfce4-keyboard-shortcuts' -p '/commands/custom/<Shift><Super>braceright' --type 'string' --set 'pactl set-sink-volume 0 +1%'
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

# Load panel config
echo "Loading panel config file..."
if [ $MON_1440 -eq 1 ]; then
    xfce4-panel-profiles load panel/SW_1440.tar.bz2
elif [ $MON_1080 -eq 1 ]; then
    xfce4-panel-profiles load panel/SW_1080.tar.bz2
elif [ $MON_1080_HTPC -eq 1 ]; then
    xfce4-panel-profiles load panel/SW_1080_htpc.tar.bz2
elif [ $MON_768 -eq 1 ]; then
    xfce4-panel-profiles load panel/SW_768.tar.bz2
fi

echo "Xfce setings configuration complete."
exit 0

