#!/bin/bash
# - SW - 30/05/2025 14:48 -
# Call helper scripts for installing and configuring Linux and importing all dotfiles

# Pretty helper
onemintimer()
{
    echo '60 second timer...'
    echo -ne '[                                                            ]\r'
    echo -ne '['

    for i in {1..60}; do
        sleep 1s
        echo -n '='
    done
    echo
}
# Reboot with timer
rebootonemin()
{
    echo "Initiating REBOOT, 1 minute from $(date). Save and close all work."
    ( onemintimer || sleep 1m )
    systemctl reboot
}

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Are we in the right place
if [ ! -f "vim/vimrc" ]; then
    echo "ERROR: Run from root of dotfiles repo"
    exit 1
fi

# Ask user which desktop they are installing (or auto-detect it?)
# TODO: Make a guess using $XDG_CURRENT_DESKTOP or similar
echo "================================================================================"
echo "Linux install helper v1.0"
echo "-------------------------"
echo "This helper script automates the installation and configuration of a Linux desktop environment"
echo "using the dotfiles and configuration settings from this dotfiles repo"
echo "WARNING: Your desktop settings and dotfiles will be overwritten by this script"
echo "If the required distro is not shown below you can use the './import-all.sh' script instead"
echo "to import dotfiles only and to not affect distro packages or flatpaks"
echo "================================================================================"
echo "Supported desktops:"
echo "- [1] Fedora (Xfce)"
echo "- [2] Fedora (GNOME)"
echo "- [3] Fedora (KDE)"
echo "- [4] Fedora (Other)"
echo "- [5] Silverblue (GNOME)"
echo ""
if [ -f "fedora-xfce-1.txt" ]; then
    echo "Found decision from previous run, loading..."
    response=1
elif [ -f "fedora-gnome-2.txt" ]; then
    echo "Found decision from previous run, loading..."
    response=2
elif [ -f "fedora-kde-3.txt" ]; then
    echo "Found decision from previous run, loading..."
    response=3
elif [ -f "fedora-other-4.txt" ]; then
    echo "Found decision from previous run, loading..."
    response=4
elif [ -f "silverblue-gnome-5.txt" ]; then
    echo "Found decision from previous run, loading..."
    response=5
else
    read -r -p 'Please select a desktop to continue (1-4): ' response
fi
FEDORA=0
SILVERBLUE=0
XFCE=0
GNOME=0
KDE=0
case "$response" in
    1)
        echo "Selected: Fedora (Xfce)"
        FEDORA=1
        XFCE=1
        echo "User selected Fedora (Xfce) 1 on $(date)" >> fedora-xfce-1.txt
        ;;
    2)
        echo "Selected: Fedora (GNOME)"
        FEDORA=1
        GNOME=1
        echo "User selected Fedora (GNOME) 2 on $(date)" >> fedora-gnome-2.txt
        ;;
    3)
        echo "Selected: Fedora (KDE)"
        FEDORA=1
        KDE=1
        echo "User selected Fedora (KDE) 3 on $(date)" >> fedora-kde-3.txt
        ;;
    3)
        echo "Selected: Fedora (Other)"
        FEDORA=1
        echo "User selected Fedora (Other) 4 on $(date)" >> fedora-other-4.txt
        ;;
    4)
        echo "Selected: Silverblue (GNOME)"
        SILVERBLUE=1
        GNOME=1
        echo "User selected Silverblue (GNOME) 5 on $(date)" >> silverblue-gnome-5.txt
        ;;
    *)
        echo "Invalid choice, aborting"
        exit 1
        ;;
esac

if [ -f "install-part-1.txt" ]; then

    echo "Part 1 already complete, skipping..."

else

    echo "Part 1:"

    if [ ! -f fedora-updated.txt ]; then
        # Passwordless sudo
        echo
        echo "Hint: Disable sudo password prompts with 'sudo visudo' and line"
        echo "    %wheel        ALL=(ALL)       NOPASSWD: ALL"
        echo
        read -r -p "Run 'sudo visudo' with 'vi' now? (y/[N]): " response
        case "$response" in
            [yY][eE][sS]|[yY])
                sudo EDITOR=vi visudo
                ;;
            *)
                ;;
        esac

        # Hostname
        echo
        read -r -p 'Set hostname of new system? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                read -p 'Enter desired hostname: ' NEWHOSTNAME
                while [[ -z "$NEWHOSTNAME" ]]; do
                    # Also catches whitespace
                    echo "ERROR: Cannot be blank."
                    read -p 'Enter desired hostname: ' NEWHOSTNAME
                done
                sudo hostnamectl set-hostname "$NEWHOSTNAME"
                ;;
            *)
                ;;
        esac
    fi

    # Do standard linux install things first like update + reboot, install base packages
    echo
    if [ $FEDORA -eq 1 ]; then
        if [ ! -f fedora-updated.txt ]; then
            echo "It is HIGHLY RECOMMENDED that you dnf upgrade all packages and reboot before continuing if this is a clean install, as dnf installs can fail otherwise"
            fedora/update.sh && echo "$(date)" >> fedora-updated.txt && exit 0
        fi
        echo "Installing fedora packages..."
        fedora/dnf-install.sh fedora/dnf-core.txt
        fedora/dnf-install.sh fedora/dnf-productivity.txt
        fedora/dnf-install.sh fedora/dnf-fonts.txt
        read -r -p 'Add hack-fonts COPR and install? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                sudo dnf copr enable zawertun/hack-fonts -y && sudo dnf install hack-fonts -y
                ;;
            *)
                ;;
        esac
        if [ $XFCE -eq 1 ]; then
            fedora/dnf-install.sh fedora/dnf-xfce.txt
            fedora/dnf-install.sh fedora/dnf-xfce-extra-themes.txt
        elif [ $GNOME -eq 1 ]; then
            fedora/dnf-install.sh fedora/dnf-gnome.txt
        elif [ $KDE -eq 1 ]; then
            fedora/dnf-install.sh fedora/dnf-kde.txt
        fi
    fi
    if [ $SILVERBLUE -eq 1 ]; then
        # TODO: Clean this up, like dnf-install
        echo "Recommended Fedora Silverblue layered packages:"
        echo "    - git"
        echo "    - tmux"
        echo "    - vim-enhanced"
        echo "    - vim-X11"
        echo "    - gnome-tweaks"
        echo "    - htop"
        echo "Upgrade base system image before continuing? (Will reboot system)"
        read -r -p "rpm-ostree upgrade and reboot? (y/[N]): " response
        case "$response" in
            [yY][eE][sS]|[yY])
                echo "Working..."; rpm-ostree upgrade && echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && ( onemintimer || sleep 1m ) && systemctl reboot && exit 0 || exit 1
                ;;
            *)
                ;;
        esac
        read -r -p 'Install recommended packages now via rpm-ostree install and reboot? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                echo "Working..."
                rpm-ostree install git tmux vim-enhanced vim-X11 gnome-tweaks htop && echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && ( onemintimer || sleep 1m ) && systemctl reboot && exit 0 || exit 1
                ;;
            *)
                ;;
        esac
    fi

    # Prompt for additional packages

    # Flatpaks
    read -r -p '- Enable flathub (SYSTEMWIDE) source for flatpak? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            echo "Done"
            echo "You can now browse and install flatpaks at https://flathub.org/home"
            echo
            if [ $SILVERBLUE -eq 1 ]; then
                flatpak/flatpak-install.sh flatpak/silverblue-core.txt
            fi
            flatpak/flatpak-install.sh flatpak/core.txt
            flatpak/flatpak-install.sh flatpak/games.txt
            flatpak/flatpak-install.sh flatpak/emulators.txt
            flatpak/flatpak-install.sh flatpak/extras.txt
            if [ $XFCE -eq 1 ]; then
                flatpak/flatpak-install.sh flatpak/xfce.txt
            elif [ $GNOME -eq 1 ]; then
                flatpak/flatpak-install.sh flatpak/gnome.txt
            fi
            ;;
        *)
            ;;
    esac
    read -r -p '- Enable flathub (USER) source for flatpak for this user only? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            echo "Done"
            echo "You can now install flatpaks for this user only with command 'flatpak install --user'"
            flatpak/flatpak-install.sh --user flatpak/work-core.txt
            ;;
        *)
            ;;
    esac

    # GNOME power saving
    if [ $GNOME -eq 1 ]; then
        echo "Fedora GNOME is now set to suspend automatically after 15 minutes inactivity at gdm login screen,"
        echo "irrespective of the user's power settings. This can be disabled with the command:"
        echo "    sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0"
        read -r -p 'Run this now, to disable automatic suspend at gdm? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
                ;;
            *)
                ;;
        esac
    fi

    # Import all dotfiles and individual misc. config files
    ./import-all.sh

    echo
    echo "Part 1 complete"
    echo "Part 1 completed on $(date)" > install-part-1.txt

    # Reboot here for xfce
    # TODO: What about GNOME and other DEs?
    if [ $XFCE -eq 1 ]; then
        echo
        echo "A reboot or reload of the user session is required for flatpaks to be on the user's path"
        echo "This is needed to properly import desktop / whiskermenu settings and launchers"
        echo "A log file has been created to return to this point after reboot, simply re-run the install script"
        read -r -p 'Reboot now? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                sudo shutdown -r 1 && exit 0
                ;;
            *)
                ;;
        esac
    fi
fi

echo
echo "Part 2:"

# Configure chosen desktop now that we have all the required programs installed
if [ $XFCE -eq 1 ]; then
    # Home bin
    echo 'Soft-link Xfce4 scripts to "~/bin", creating dir. and adding to ".bashrc" "$PATH" if necessary...'
    xfce4/softlink-xfce-bin.sh

    # General xfce settings & panel
    read -r -p 'Load Xfce4 settings via xfconf-query? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            xfce4/set-xfce.sh
            ;;
        *)
            ;;
    esac

    # Session & Startup
    echo "Import Session & Startup autostart config files..."
    if [ ! -d ~/.config/autostart ]; then
        echo "Creating '~/.config/autostart' directory..."
        mkdir -p ~/.config/autostart
    fi
    echo -n "Copying files... "
    cp -a xfce4/autostart/. ~/.config/autostart
    echo "Done"

    # Flameshot
    echo "Flameshot config..."
    if [ ! -d ~/Pictures/Screenshots ]; then
        echo "Making '~/Pictures/Screenshots' dir..."
        mkdir -p ~/Pictures/Screenshots
    fi
    if [ ! -d ~/.config/flameshot ]; then
        echo "Making '~/.config/flameshot' dir..."
        mkdir -p ~/.config/flameshot
    fi
    if [ -f ~/.config/flameshot/flameshot.ini ]; then
        echo "File '~/.config/flameshot/flameshot.ini' already exists, skipping"
    else
        echo "Creating flameshot config file '~/.config/flameshot/flameshot.ini'..."
        echo "[General]" > ~/.config/flameshot/flameshot.ini
        echo "filenamePattern=Screenshot_%F_%H-%M-%S" >> ~/.config/flameshot/flameshot.ini
        echo "savePath=/home/${USER}/Pictures/Screenshots" >> ~/.config/flameshot/flameshot.ini
        echo "savePathFixed=true" >> ~/.config/flameshot/flameshot.ini
    fi
elif [ $GNOME -eq 1 ]; then
    # Home bin
    echo 'Soft-link GNOME scripts to "~/bin", creating dir. and adding to ".bashrc" "$PATH" if necessary...'
    gnome/softlink-gnome-bin.sh
    echo "xfce4-terminal launcher..."
    launchers/create-launcher.sh launchers/xfce4-terminal.desktop
    # GNOME
    read -r -p 'Load GNOME settings via dconf? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            # Idempotent settings, can be re-run later
            gnome/load-dconf-settings.sh gnome/dconf-settings.ini
            # Additional settings for first run on clean install only (e.g. favourite pinned apps, don't want to remove extras added later)
            if command -v xfce4-terminal &> /dev/null ; then
                gnome/load-dconf-settings.sh gnome/dconf-settings-firstrun-xfce4terminal.ini
            else
                gnome/load-dconf-settings.sh gnome/dconf-settings-firstrun.ini
            fi
            # User's choice x2
            read -r -p 'Enable 1.2x scaling for 1440p displays? (y/[N]): ' response2
            case "$response2" in
                [yY][eE][sS]|[yY])
                    gnome/load-dconf-settings.sh gnome/dconf-settings-1440p.ini
                    # Update neovim-qt fonts while we're here
                    sed -i 's/h10/h13/g' ~/.config/nvim/ginit.vim
                    ;;
                *)
                    ;;
            esac
            read -r -p 'Optimise for VM / RDP? (No idle lockscreen or animations etc.)? (y/[N]): ' response2
            case "$response2" in
                [yY][eE][sS]|[yY])
                    gnome/load-dconf-settings.sh gnome/dconf-settings-vm-or-remote.ini
                    ;;
                *)
                    ;;
            esac
            ;;
        *)
            ;;
    esac
fi

# SSH keygen
if [ ! -f ~/.ssh/id_ed25519.pub ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -a 100
fi

# virt-manager libvirt group
# If it exists then assume we want to be in it
if [ $(getent group libvirt) ]; then
    echo "Adding user '$USER' to 'libvirt' group..."
    sudo usermod -a -G libvirt $USER
fi

echo
echo "===== OPTIONAL ================================================================="
echo "Some extra things you might want to do now"
echo "- Change user account avatar"
echo "- Add SSH public key to GitHub:"
echo "--------------------------------------------------------------------------------"
cat ~/.ssh/id_ed25519.pub
echo "--------------------------------------------------------------------------------"
# if [[ "$silverblue" == "no" ]]; then
#     read -r -p '- Install default Fedora wallpapers since F25 and extras since F36? (y/[N]): ' response
#     case "$response" in
#         [yY][eE][sS]|[yY])
#             # This can actually be done since f21 for gnome and extras-gnome, but not all are good
#             echo "Installing default wallpapers f25 to f$(rpm -E %fedora)-backgrounds-gnome..."
#             eval sudo dnf install -y f{25..$(rpm -E %fedora)}-backgrounds-gnome
#             echo "Installing extra wallpapers f36 to f$(rpm -E %fedora)-backgrounds-extras-gnome..."
#             eval sudo dnf install -y f{36..$(rpm -E %fedora)}-backgrounds-extras-gnome
#             ;;
#         *)
#             ;;
#     esac
# fi
echo "- Sign into Firefox account"
if [ $GNOME -eq 1 ]; then
    echo "- Install GNOME Extensions from https://extensions.gnome.org/"
    echo "    - E.g. https://extensions.gnome.org/extension/615/appindicator-support/"
fi
if [ $FEDORA -eq 1 ]; then
    echo "- Enable RPM Fusion"
    echo "    - https://rpmfusion.org/Configuration"
    read -r -p "Enable and install RPM Fusion repositories now? (y/[N]): " response
    case "$response" in
        [yY][eE][sS]|[yY])
            fedora/rpmfusion.sh
            ;;
        *)
            ;;
    esac
    echo "Multimedia codecs should be done manually, since they depend on your CPU and/or GPU architecture (Intel, AMD, Nvidea etc.):"
    echo "    - https://rpmfusion.org/Howto/Multimedia?highlight=%28%5CbCategoryHowto%5Cb%29"
    echo "    - Install mpv, vlc, smplayer"
    fedora/dnf-install.sh fedora/dnf-multimedia.txt
fi
echo "- Install VS Code"
echo "- Set up SSH config file and known hosts, distribute public key (bitwarden?)"
echo "- Delete and re-clone dotfiles repo via SSH key auth for future commits:"
echo "    cd ../ && rm -rf dotfiles/ && git clone git@github.com:siwatts/dotfiles.git"
echo "- Run included './diff-all.sh' script to catch any remaining files"
echo "- Monitor brightness scripts './monitor-controls/README.md'"
echo "- Install Microsoft Windows fonts"
echo "- Reboot so that flatpaks and autostart applications take effect"

# Other helpful system config or prompts from import-all script
# TODO: Add an SSH service enable and password login disable

echo "Program complete"
exit 0

