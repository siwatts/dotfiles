#!/bin/bash
# - 02/09/2018 - SW -
# Configure xfce settings using xfconf-query, and import terminal settings:

# First import xfce4-terminal config:
if [ ! -d "~/.config/xfce4/terminal" ]; then
    # Make it
    mkdir -p ~/.config/xfce4/terminal
fi
if [ -f "terminal/terminalrc" ]; then
    if [ -f "~/.config/xfce4/terminal/terminalrc" ]; then
        # There is already a terminal config file, diff it.
        vim -d ~/.config/xfce4/terminal/terminalrc terminal/terminalrc
        # Or backup and replace
        #mv ~/.config/xfce4/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc.bak
        #cp terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
    else
        # None, so copy ours.
        cp terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
        echo "Imported xfce4-terminal settings. Close all running instances to take effect."
    fi
else
    echo "Warning: Could not find dotfiles xfce4-terminal 'terminalrc' file."
    echo "Please run from dotfiles 'xfce4' directory to import this."
    echo "Continuing with xfce configuration..."
fi

echo "Configuring xfce with 'xfconf-query'..."

# =======================================================
# ~/.config/xfce4/xfconf/xfce-perchannel-xml/keyboards.xml
# =======================================================
xfconf-query -c keyboards -p /Default/Numlock -s true

# =======================================================
# ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
# =======================================================
# /commands/custom appear to be a duplicate of /commands/default on clean
# Xubuntu install. Custom are created or replaced accordingly and default
# left unaffected. Default do no influence behaviour but are probably used
# when 'Reset to Defaults' is called.
# ====
# Volume control:
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioRaiseVolume -n -t string -s 'pactl set-sink-volume 0 +5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioLowerVolume -n -t string -s 'pactl set-sink-volume 0 -5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioMute -n -t string -s 'pactl set-sink-mute 0 toggle'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'KP_Add -n -t string -s 'pactl set-sink-volume 0 +5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'Page_Up -n -t string -s 'pactl set-sink-volume 0 +5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'equal -n -t string -s 'pactl set-sink-volume 0 +5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'KP_Subtract -n -t string -s 'pactl set-sink-volume 0 -5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'Page_Down -n -t string -s 'pactl set-sink-volume 0 -5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'minus -n -t string -s 'pactl set-sink-volume 0 -5%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Shift><Super>'KP_Add -n -t string -s 'pactl set-sink-volume 0 +1%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Shift><Super>'Page_Up -n -t string -s 'pactl set-sink-volume 0 +1%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Shift><Super>'plus -n -t string -s 'pactl set-sink-volume 0 +1%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Shift><Super>'KP_Subtract -n -t string -s 'pactl set-sink-volume 0 -1%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Shift><Super>'Page_Down -n -t string -s 'pactl set-sink-volume 0 -1%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Shift><Super>'underscore -n -t string -s 'pactl set-sink-volume 0 -1%'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'KP_Multiply -n -t string -s 'pactl set-sink-mute 0 toggle'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'KP_Divide -n -t string -s 'pactl set-sink-volume 0 50%'
# Special keys:
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86Explorer -n -t string -s 'Thunar'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86LogOff -n -t string -s 'xfce4-session-logout'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86Terminal -n -t string -s 'xfce4-terminal'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioNext -n -t string -s 'pragha --next'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioPrev -n -t string -s 'pragha --prev'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioMedia -n -t string -s 'pragha'
#xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86Memo -n -t string -s 'xfce4-notes'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86AudioPlay -n -t string -s 'pragha --pause'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86Display -n -t string -s 'xfce4-display-settings --minimal'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86Mail -n -t string -s 'exo-open --launch MailReader'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86WWW -n -t string -s 'exo-open --launch WebBrowser'
#xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86Calculator -n -t string -s 'galculator'
#xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/XF86Calendar -n -t string -s 'orage'
# Screenshots:
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/Print -n -t string -s 'xfce4-screenshooter -f'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Alt>'Print -n -t string -s 'xfce4-screenshooter -w'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Shift>'Print -n -t string -s 'xfce4-screenshooter'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Primary>'Print -n -t string -s 'xfce4-screenshooter -r'
# Xfce things:
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/override -n -t string -s 'true'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Primary>'Escape -n -t string -s 'xfdesktop --menu'
#xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Primary>'Escape -n -t string -s 'xfce4-popup-whiskermenu'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'p -n -t string -s 'xfce4-display-settings --minimal'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Alt>'F1 -n -t string -s 'xfce4-popup-applicationsmenu'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'r -n -t string -s 'xfce4-appfinder --collapsed'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'r/startup-notify -n -t bool -s true
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Alt>'F2 -n -t string -s 'xfce4-appfinder --collapsed'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Alt>'F2/startup-notify -n -t bool -s true
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Alt>'F3 -n -t string -s 'xfce4-appfinder'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Alt>'F3/startup-notify -n -t bool -s true
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Control><Alt>'Escape -n -t string -s 'xkill'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Primary><Alt>'Delete -n -t string -s 'xflock4'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'l -n -t string -s 'xflock4'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Primary><Alt>'l -n -t string -s 'xflock4'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'d -n -t string -s 'xfdashboard'
# Applications:
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'f -n -t string -s 'firefox --private-window'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'w -n -t string -s 'firefox'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'e -n -t string -s 'thunar'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'g -n -t string -s 'gvim'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'a -n -t string -s 'xfce4-popup-whiskermenu'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Primary>'apostrophe -n -t string -s 'xfce4-terminal --drop-down'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'c -n -t string -s 'google-chrome-stable'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Primary><Alt>'t -n -t string -s 'exo-open --launch TerminalEmulator'
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/'<Super>'t -n -t string -s 'xfce4-terminal'
# Xfwm shortcuts:
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'Insert -n -t string -s 'add_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'Delete -n -t string -s 'del_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F4 -n -t string -s 'close_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F6 -n -t string -s 'stick_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F7 -n -t string -s 'move_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F8 -n -t string -s 'resize_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F9 -n -t string -s 'hide_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F10 -n -t string -s 'maximize_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F11 -n -t string -s 'fullscreen_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'F12 -n -t string -s 'above_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'Tab -n -t string -s 'cycle_windows_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt><Shift>'Tab -n -t string -s 'cycle_reverse_windows_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Alt>'space -n -t string -s 'popup_menu_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F1 -n -t string -s 'workspace_1_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F2 -n -t string -s 'workspace_2_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F3 -n -t string -s 'workspace_3_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F4 -n -t string -s 'workspace_4_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F5 -n -t string -s 'workspace_5_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F6 -n -t string -s 'workspace_6_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F7 -n -t string -s 'workspace_7_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F8 -n -t string -s 'workspace_8_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F9 -n -t string -s 'workspace_9_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F10 -n -t string -s 'workspace_10_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F11 -n -t string -s 'workspace_11_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary>'F12 -n -t string -s 'workspace_12_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'Down -n -t string -s 'down_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'End -n -t string -s 'move_window_next_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'Home -n -t string -s 'move_window_prev_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_1 -n -t string -s 'move_window_workspace_1_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_2 -n -t string -s 'move_window_workspace_2_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_3 -n -t string -s 'move_window_workspace_3_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_4 -n -t string -s 'move_window_workspace_4_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_5 -n -t string -s 'move_window_workspace_5_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_6 -n -t string -s 'move_window_workspace_6_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_7 -n -t string -s 'move_window_workspace_7_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_8 -n -t string -s 'move_window_workspace_8_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'KP_9 -n -t string -s 'move_window_workspace_9_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'Left -n -t string -s 'left_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'Right -n -t string -s 'right_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'Up -n -t string -s 'up_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Shift><Alt>'Left -n -t string -s 'move_window_left_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Shift><Alt>'Right -n -t string -s 'move_window_right_workspace_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Alt>'d -n -t string -s 'show_desktop_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Shift><Alt>'Left -n -t string -s 'move_window_left_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Shift><Alt>'Right -n -t string -s 'move_window_right_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Primary><Shift><Alt>'Up -n -t string -s 'move_window_up_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Shift><Alt>'Page_Down -n -t string -s 'lower_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Shift><Alt>'Page_Up -n -t string -s 'raise_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'Tab -n -t string -s 'switch_window_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/Up -n -t string -s 'up_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/Down -n -t string -s 'down_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/Left -n -t string -s 'left_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/Right -n -t string -s 'right_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/Escape -n -t string -s 'cancel_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/override -n -t string -s 'true'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'Up -n -t string -s 'tile_up_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'Down -n -t string -s 'tile_down_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'Left -n -t string -s 'tile_left_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'Right -n -t string -s 'tile_right_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'KP_1 -n -t string -s 'tile_down_left_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'KP_3 -n -t string -s 'tile_down_right_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'KP_7 -n -t string -s 'tile_up_left_key'
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/'<Super>'KP_9 -n -t string -s 'tile_up_right_key'

# ==========================================
# ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
# ==========================================

# ====================================
# ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
# ====================================
xfconf-query -c xfwm4 -p /general/button_layout -s 'O|HMC'
xfconf-query -c xfwm4 -p /general/cycle_apps_only -s 'false'
xfconf-query -c xfwm4 -p /general/cycle_draw_frame -s 'false'
xfconf-query -c xfwm4 -p /general/cycle_tabwin_mode -s '1'
xfconf-query -c xfwm4 -p /general/mousewheel_rollup -s 'false'
xfconf-query -c xfwm4 -p /general/placement_ratio -s '100'
xfconf-query -c xfwm4 -p /general/scroll_workspaces -s 'false'
#xfconf-query -c xfwm4 -p /general/theme -s 'Arc-Darker'
#xfconf-query -c xfwm4 -p /general/title_font -s 'Sans Bold 9'
#xfconf-query -c xfwm4 -p /general/title_font -s 'Noto Sans Bold 9'
xfconf-query -c xfwm4 -p /general/wrap_cycle -s 'false'
xfconf-query -c xfwm4 -p /general/wrap_layout -s 'false'

# ========================================
# ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
# ========================================
#xfconf-query -c xsettings -p /Net/ThemeName -s 'Arc-Darker-solid'
#xfconf-query -c xsettings -p /Net/IconThemeName -s 'gnome'
#xfconf-query -c xsettings -p /Net/IconThemeName -s 'Fedora'
xfconf-query -c xsettings -p /Net/CursorBlink -s 'false'

#xfconf-query -c xsettings -p /Gtk/FontName -s 'Noto Sans 10'
#xfconf-query -c xsettings -p /Gtk/FontName -s 'Sans 10'
#xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s 'Monospace 11'
#xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s 'Terminus 12'
#xfconf-query -c xsettings -p /Gtk/CursorThemeName -s 'DMZ-Black'
xfconf-query -c xsettings -p /Gtk/DecorationLayout -s 'menu:minimize,maximize,close'

echo "Configuration complete."

