#!/bin/bash
# - SW - 20/11/2022 19:26 -
# Import or softlink all contents of dotfiles relevant to a GNOME desktop, interactively, for a clean install / user account

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

# cd to location of script, even if soft-linked
pushd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Are we in the right place
if [ ! -f "vim/vimrc" ]; then
    echo "ERROR: Run from root of dotfiles repo"
    exit 1
fi

echo "This script imports files from dotfiles to a clean install of a local system for the first time"
echo "If already present files are appended with '.bak' for later comparison"
echo "We assume you are setting up a DE like GNOME and want to import everything"
echo
read -r -p 'Do you wish to continue? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Okay"
        ;;
    *)
        exit 1
        ;;
esac

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

read -r -p 'Set hostname of new system? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        read -p 'Enter desired hostname: ' NEWHOSTNAME
        if [[ -z "$NEWHOSTNAME" ]]; then
            # Also catches whitespace
            echo "Error: Cannot be blank."
            exit 1
        else
            sudo hostnamectl set-hostname "$NEWHOSTNAME"
        fi
        ;;
    *)
        ;;
esac

read -r -p "Is this a Silverblue install? (y/[N]): " silverblue
case "$silverblue" in
    [yY][eE][sS]|[yY])
        silverblue=yes
        ;;
    *)
        silverblue=no
        ;;
esac
if [[ "$silverblue" == "yes" ]]; then
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
else
    echo "Recommended Fedora packages:"
    echo "    - git"
    echo "    - tmux"
    echo "    - xfce4-terminal"
    echo "    - vim-enhanced"
    echo "    - vim-X11"
    echo "    - gnome-extensions-app"
    echo "    - gnome-tweaks"
    echo "    - gimp"
    echo "    - remmina"
    echo "    - htop"
    echo "    - neovim-qt"
    echo "    - virt-manager"
    echo "It is HIGHLY RECOMMENDED that you dnf upgrade all packages and reboot before doing this if this is a clean install, as dnf can error otherwise"
    read -r -p 'DNF upgrade all packages and reboot now? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            echo "Using DNF offline-upgrade plugin can be more safe on a physical machine, but is not pre-installed on some systems like the KDE spin and can cause issues in some VMs"
            read -r -p 'Use more risky fallback live dnf upgrade in current login session? (recommended for VMs)? (y/[N]): ' response
            case "$response" in
                [yY][eE][sS]|[yY])
                    echo "Working..."; sudo dnf upgrade -y && echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && ( onemintimer || sleep 1m ) && systemctl reboot && exit 0 || exit 1
                    ;;
                *)
                    echo "Working..."; sudo dnf offline-upgrade download -y && echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && ( onemintimer || sleep 1m ) && sudo dnf offline-upgrade reboot
                    ;;
            esac
            ;;
        *)
            ;;
    esac
    read -r -p 'Install recommended packages now via dnf? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            echo "Working..."
            sudo dnf install -y git tmux xfce4-terminal vim-enhanced vim-X11 gnome-extensions-app gnome-tweaks gimp remmina htop virt-manager
            sudo dnf install -y neovim-qt
            ;;
        *)
            ;;
    esac
fi

echo "Importing files..."

echo "Bashrc..."
if [ -f ~/.bashrc ]; then
    if [ -f ~/.bashrc.bak ]; then
        echo "ERROR: '~/.bashrc.bak' already exists"
        exit 1
    fi
    mv ~/.bashrc ~/.bashrc.bak
fi
cp -a bashrc ~/.bashrc

echo "Vimrc..."
if [ -f ~/.vimrc ]; then
    if [ -f ~/.vimrc.bak ]; then
        echo "ERROR: '~/.vimrc.bak' already exists"
        exit 1
    fi
    mv ~/.vimrc ~/.vimrc.bak
fi
cp -a vim/vimrc ~/.vimrc

# Vim colours
echo "Vim files..."
mkdir -p ~/.vim/colors
cp -a vim/colors ~/.vim
cp -a vim/custom_colors/. ~/.vim/colors
cp -a vim/syntax ~/.vim
cp -a vim/plugin ~/.vim
sed -i 's/^let use_custom_theme=0/let use_custom_theme=1/g' ~/.vimrc
sed -i 's/^let use_truecolor=0/let use_truecolor=1/g' ~/.vimrc
sed -i 's/"set guifont=Source/set guifont=Source/g' ~/.vimrc
sed -i 's/set guifont=Monospace/"set guifont=Monospace/g' ~/.vimrc

# Gitk, with modified fonts
echo "Gitk config..."
if [ ! -d ~/.config/git ]; then
    mkdir -p ~/.config/git
fi
if [ -f ~/.config/git/gitk ]; then
    mv ~/.config/git/gitk{,.bak}
fi
cp -a gitk ~/.config/git

# Neovim
echo "Neovim init.vim and ginit.vim..."
mkdir -p ~/.config/nvim
ln -sf `pwd`/vim/{,g}init.vim ~/.config/nvim

# Xfce4-terminal
echo "xfce4-terminal config..."
mkdir -p ~/.config/xfce4/terminal
cp -a xfce4/terminal/terminalrc ~/.config/xfce4/terminal
# No harm to bring in config file anyway, but check xfce4-terminal is installed
# before softlinking all themes and making a custom launcher
if command -v xfce4-terminal &> /dev/null ; then
    echo "xfce4-terminal colours..."
    terminal/sync-xfce4-terminal-themes.sh
    echo "xfce4-terminal launcher..."
    launchers/create-launcher.sh launchers/xfce4-terminal.desktop
fi

# Tmux.conf
echo "tmux.conf..."
cp -a tmux.conf ~/.tmux.conf

# Git config
echo "gitconfig..."
cp -a gitconfig ~/.gitconfig

# Home bin
echo 'Soft-link GNOME scripts to "~/bin", creating dir. and adding to ".bashrc" "$PATH" if necessary...'
gnome/softlink-gnome-bin.sh

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

read -r -p 'Install and set some custom fonts for Fedora? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        gnome/fonts-for-fedora.sh
        ;;
    *)
        ;;
esac

echo
echo "Import complete"

if [ -f ~/.bashrc.bak ]; then
    echo
    read -r -p 'Compare imported .bashrc to pre-existing .bashrc.bak? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            if command -v vim &> /dev/null ; then
                vim -d ~/.bashrc ~/.bashrc.bak
            else
                # Fallback if vim not installed
                diff ~/.bashrc ~/.bashrc.bak
            fi
            ;;
        *)
            ;;
    esac
fi
echo

if [ ! -f ~/.ssh/id_ed25519.pub ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -a 100
fi

echo
echo "===== OPTIONAL ================================================================="
echo "Some extra things you might want to do now"
echo "- Change user account avatar"
echo "- Add SSH public key to GitHub:"
echo "--------------------------------------------------------------------------------"
cat ~/.ssh/id_ed25519.pub
echo "--------------------------------------------------------------------------------"
if [[ "$silverblue" == "no" ]]; then
    read -r -p '- Install default Fedora wallpapers since F25 and extras since F36? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            # This can actually be done since f21 for gnome and extras-gnome, but not all are good
            echo "Installing default wallpapers f25 to f$(rpm -E %fedora)-backgrounds-gnome..."
            eval sudo dnf install -y f{25..$(rpm -E %fedora)}-backgrounds-gnome
            echo "Installing extra wallpapers f36 to f$(rpm -E %fedora)-backgrounds-extras-gnome..."
            eval sudo dnf install -y f{36..$(rpm -E %fedora)}-backgrounds-extras-gnome
            ;;
        *)
            ;;
    esac
fi
read -r -p '- Enable flathub (SYSTEMWIDE) source for flatpak? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        echo "Done"
        echo "You can now browse and install flatpaks at https://flathub.org/home"
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
        echo "E.g."
        echo "--"
        cat flatpak/work-core.txt
        echo "--"
        read -r -p '- Install the above for this user only? (y/[N]): ' response
        case "$response" in
            [yY][eE][sS]|[yY])
                flatpak/flatpak-install.sh --user flatpak/work-core.txt -y
                echo "Done"
                ;;
            *)
                ;;
        esac
        ;;
    *)
        ;;
esac
echo "- Install core flatpaks globally:"
echo "--"
cat flatpak/core.txt
echo "--"
read -r -p '- Install the above flatpaks now for ALL users? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        flatpak/flatpak-install.sh flatpak/core.txt -y
        ;;
    *)
        ;;
esac
if [[ "$silverblue" == "yes" ]]; then
    echo "- Install extra flatpaks for Silverblue globally:"
    echo "--"
    cat flatpak/silverblue-core.txt
    echo "--"
    read -r -p '- Install the above flatpaks now for ALL users? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            flatpak/flatpak-install.sh flatpak/silverblue-core.txt -y
            ;;
        *)
            ;;
    esac
fi
echo "- Install extra flatpaks globally:"
echo "--"
cat flatpak/extras.txt
echo "--"
read -r -p '- Install the above flatpaks now for ALL users? (y/[N]): ' response
case "$response" in
    [yY][eE][sS]|[yY])
        flatpak/flatpak-install.sh flatpak/extras.txt -y
        ;;
    *)
        ;;
esac
echo "- Sign into Firefox account"
echo "- Install GNOME Extensions from https://extensions.gnome.org/"
echo "    - E.g. https://extensions.gnome.org/extension/615/appindicator-support/"
if [[ "$silverblue" == "no" ]]; then
    echo "- Enable RPM Fusion"
    echo "    - https://rpmfusion.org/Configuration"
    echo "Warning, make sure dnf packages up to date. Commands correct as of Fedora 39 13/03/2024 20:45"
    read -r -p '- Carry out the above steps as retrieved on 13/03/2024 20:45? (y/[N]): ' response
    case "$response" in
        [yY][eE][sS]|[yY])
            echo "RPM Fusion..."
            sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
            sudo dnf config-manager --enable fedora-cisco-openh264 -y
            ;;
        *)
            ;;
    esac
    echo "Multimedia codecs should be done manually, since they depend on your CPU and/or GPU architecture (Intel, AMD, Nvidea etc.):"
    echo "    - https://rpmfusion.org/Howto/Multimedia?highlight=%28%5CbCategoryHowto%5Cb%29"
    echo "    - Install mpv, vlc player"
fi
echo "- Install VS Code"
echo "- Set up SSH config file and known hosts, distribute public key (bitwarden?)"
echo "- Delete and re-clone dotfiles repo via SSH key auth for future commits:"
echo "    cd ../ && rm -rf dotfiles/ && git clone git@github.com:siwatts/dotfiles.git"
echo "- Run included './diff-all.sh' script to catch any remaining files"
echo "- Monitor brightness scripts './monitor-controls/README.md'"
echo "- Install Microsoft Windows fonts"

echo
echo "Program complete"

exit 0

