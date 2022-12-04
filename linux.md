# Installing Linux

## Window Managers / Desktop Environments

- [Xfce4](xfce4/README.md)
- [Openbox](openbox/README.md)
- [i3wm](i3wm/README.md)

## General Fixes

Fix X11 screentearing on AMD Radeon: `sudo vim /usr/share/X11/xorg.conf.d/20-radeon.conf`
```
Section "Device"
    Identifier "Radeon"
    Driver "radeon"
    Option "TearFree" "on"
EndSection
```

Fix X11 screentearing on Intel integrated graphics: `sudo vim /etc/X11/xorg.conf`
```
Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "AccelMethod" "sna"
    Option "TearFree" "true"
EndSection
```

Fix flashing backlight (Ubuntu 18.04 Thinkpad T420):
- `sudo vim /etc/default/grub`
- Line `GRUB_CMDLINE_LINUX_DEFAULT`, append ` acpi_backlight=native`. Eg.
    - `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=native"`

Stop laptop suspend on lid close:
- `sudo vim /etc/systemd/logind.conf`
    - `HandleLidSwitch=ignore`

Stop cursor blinking, everywhere
- Xfce 4.10+: `xfconf-query -c xsettings -p /Net/CursorBlink -T`
- GNOME 3: `gsettings set org.gnome.desktop.interface cursor-blink false`
- MATE: `gsettings set org.mate.interface cursor-blink false`
- Firefox: Should respect DE, but if doesn't start it to generate a profile
  then:
    - `about:config, New -> Integer, ui.caretBlinkTime 0`
- More programs, other methods, and methods for older versions available at
  [source webpage](https://jurta.org/en/prog/noblink)

## Creating bootable USB drive

Write `.iso` to usb drive using `dd` raw byte copy command. **This will wipe
whatever output destination you choose so be careful.** Instructions presented
here for reference only.

```
# Identify usb drive.
sudo -i fdisk -l
lsblk

# Unmount any mounted partition of drive. Eg. if /dev/sdb
umount /dev/sdbX

# Navigate to loc. of .iso.
# Copy to drive
sudo dd bs=4M if=xubuntu-18.04.2-desktop-amd64.iso of=/dev/sdb status=progress && sync
```

## Reformat USB drive as data drive when done

If `dd` or similar has been used to create an iso image, will need to
repartition:

As root:

- `fdisk -l`, note USB drive letter `X` where drive is `/dev/sdX`
- `umount /dev/sdX1`, ensure unmounted before beginning
- `fdisk /dev/sdX`
    - `d`, to delete partition
    - `1`, for first partition
    - Repeat for all partitions
    - `n`, make new partition
    - `p`, type: primary partition
    - `1`, make it first partition
    - Press _ENTER_ to accept default first and sectors (uses full drive space)
    - `w`, write changes to drive
- `umount /dev/sdX1`, unmount newly created first partition
- `mkfs.vfat -F 32 /dev/sdX1`, make FAT32 filesystem

Misc:
- Can force `unmount` with `-f`, or `-l` (lazy umount)
- To remove usb drive, better to use `eject` (as superuser), which does
  everything in one operation

## Enable grub menu

- `sudo vim /etc/default/grub`
- Change `GRUB_TIMEOUT_STYLE` from `hidden` to `menu`, or comment line out
  (`menu` is default option).
- Change `GRUB_TIMEOUT` to desired value in seconds, or give no value.
- Alternatively, older versions, comment line `GRUB_HIDDEN_TIMEOUT=0`
- Save and close
- `sudo update-grub`
    - This can also detect other OS on other connected HDD and add to grub
    - Might be Ubuntu specific

## Display Managers

- Start an X session directly with `startx`, this will execute whatever is in
  `~/.xinitrc` (eg. `exec i3`).

### LightDM

- Start lightdm session with `sudo /etc/init.d/lightdm start`.
- Enable `lightdm.service` in systemd if no assigned dm.
    - `systemctl start <unit>`
    - `systemctl stop <unit>`
    - `systemctl status <unit>`
    - `systemctl enable <unit>`, will be started on boot.
    - `systemctl enable --now <unit>`, on boot and now.
    - `systemctl disable <unit>`, don't start on boot.

LightDM Settings:
- `sudoedit /etc/lightdm/lightdm.conf`
    - List possible greeters with `ls -l /usr/share/xgreeters/`
    - List possible DEs with `ls -l /usr/share/xsessions/`
    - Comment the autologin lines if you wish to disable auto-login (which is
      enabled by default on raspbian).
```yaml
[Seat:*]
greeter-session=lightdm-gtk-greeter
greeter-hide-users=false
autologin-user=<user>
autologin-user-timeout=0
```

Lightdm GTK Greeter Settings:
- `sudoedit /etc/lightdm/lightdm-gtk-greeter.conf`
```yaml
[greeter]
background = /usr/share/backgrounds/taeyeon_i_AL8AtY4.jpg
theme-name = Arc-Dark
icon-theme-name = Fedora
clock-format = %a %d/%m/%y, %H:%M:%S
font-name = Noto Sans 10 
active-monitor = 0
```

## Raspberry Pi

Display settings:
- No bios, settings in `/boot/config.txt`.
- Defaults to 1360x768.
- List current screen setting: `/opt/vc/bin/tvservice -s`.
- List available screen settings:
    - `/opt/vc/bin/tvservice -m CEA`, (hdmi_group 1).
    - `/opt/vc/bin/tvservice -m DMT`, (hdmi_group 2).
    - Can override default using `hdmi_group` and `hdmi_mode`.
    - May need to disable overscan with `disable_overscan=1`.

## SSH

- `.ssh` directory should be `rwx` for owner only, ie. `mkdir ~/.ssh && chmod
  700 ~/.ssh`.
- Copy local public key `~/.ssh/id_rsa.pub` to target machine, append in its full
  form to target `~/.ssh/authorized_keys` file.
    - `scp ~/.ssh/id_rsa.pub destination:id_rsa.pub`, if keyless ssh using
      password is allowed.
    - `cat id_rsa.pub >> ~/.ssh/authorized_keys`
- Disable password login to enforce key access only.
    - `sudoedit /etc/ssh/sshd_config`
    - `PasswordAuthentication no`
    - `sudo systemctl restart sshd.service`
    - `sudo service ssh restart`

## Fedora

Adding a DNF / copr repository:
- `dnf config-manager --add-repo <repository_url>`
    - where `<repository_url>` is the path to a `.repo` file.

DNF configuration files live in `/etc/yum.repos.d/`
    - List all enabled: `dnf repolist`
    - Disable: `dnf config-manager --set-disabled <repoid>`
    - Disable copr: `dnf copr disable <name/project>`
    - Can manually set `enabled=0` in `.repo` file

Adding rpmfusion non-free repos:
- `sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`

H264 media codecs:
- `sudo dnf config-manager --set-enabled fedora-cisco-openh264`
- `sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264`
- Afterwards you need open Firefox, go to menu -> Add-ons -> Plugins and enable OpenH264 plugin.
- `sudo dnf install compat-ffmpeg28`

DVD playback:
- Add all livna.org hosted additional packages, and install `libdvdcss`:
    - `sudo rpm -ivh http://rpm.livna.org/livna-release.rpm`
    - `sudo dnf install -y libdvdcss`
- Alternatively install only the required library, eg:
    - `sudo rpm -ivh http://rpm.livna.org/repo/40/x86_64/libdvdcss-1.4.1-1.fc27.remi.x86_64.rpm`

### Sound Bugs

Fedora 35 uses pipewire
- Tinny sound bug encountered sometimes after suspend
- Can check on and restart pipewire to fix this
- Stop any playing media
- `systemctl --user restart pipewire`

### dnf packages

Some of the dnf packages used in Fedora 27 install:

#### Productivity
- `vim-enhanced`
- `tmux`
- `xterm`
- `gitk git-gui`
- `/usr/bin/gvim`
- `rxvt-unicode-256color`
- `htop`
- `gcc make perl`
- `neofetch`
- `neovim`
- `python2-neovim python3-neovim`
- `codeblocks`
- `gcc-c++`
- `ranger`
- `dotnet-sdk-2.1`
- `code`
- `geany `
- `geany-themes `
- `sqlite`
- `mousepad`

#### Other Apps
- `mpv`
- `vlc`

#### XFCE
- `@xfce-desktop-environment`
- `xfce4-whiskermenu-plugin`
- `light-locker`
- `xfce-theme-manager`
- `xfce4-genmon-plugin`
- `xfdashboard xfdashboard-themes`
- `xfce4-timer-plugin`

#### Look and Feel
- `arc-theme`
- `redshift redshift-gtk`
- `terminus-fonts terminus-fonts-console`
- `levien-inconsolata-fonts`
- `adobe-source-code-pro-fonts`
- `google-noto-mono-fonts google-noto-sans-fonts`
- `msimonson-anonymouspro-fonts`
- `hack-fonts `
- `dmz-cursor-themes`

#### i3
- `i3 i3status dmenu i3lock xbacklight feh conky`
- `ofono`
- `arandr`
- `lxappearance`
- `rofi`

#### Misc
- `gstreamer`
- `mozilla-openh264 gstreamer1-plugin-openh264`
- `https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-27.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-27.noarch.rpm`
- `ffmpeg`
- `xorg-x11-drv-amdgpu mesa-libGL.i686 mesa-dri-drivers.i686`
- `lshw`
- `p7zip`
- `kernel-devel-4.15.6-300.fc27.x86_64`
- `cool-retro-term`
- `st`
- `binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms`
- `VirtualBox-5.2`
- `compton`
- `obconf`
- `python3-tools`
- `fuse-exfat (fat file system utils)`

## OpenSUSE Tumbleweed

### Zypper Packages

#### Themes

## Stress Testing a System

- `sensors` is a useful command to monitor system stats
    - Get it by installing `lm_sensors` (or `lm-sensors` in apt)
    - Run `sudo sensors-detect`, hit ENTER to answer default response to all q's
      for safest approach
    - Can now watch CPU temps with `watch -n1 sensors`
- Program `stress` can put load on CPU or other systems
    - Package name `stress`
    - To put load on CPU and spin 8 `sqrt()` workers (for 8 cores/threads).
      Verbose prints more info to screen. Stops after 30s.
        - `sudo stress --cpu 8 -v --timeout 30s`
    - Recommended to be run as root by [article](https://www.tecmint.com/linux-cpu-load-stress-test-with-stress-ng-tool/)

## Fixing Mouse DPI - Wayland / systemd / libinput

On a distro like Fedora using GNOME, wayland is used to handle input devices.
These are abstracted under libinput, and not xinput / xset

Microsoft Intellimouse Pro uses a 1600dpi sensor. libinput assumes 1000dpi when it does not know otherwise, or attempts to normalise all input devices over 1000dpi to behave as if 1000dpi. However, this mouse is far too sensitive by default, and when measured appeared to be
treated as 1000dpi and not normalised.

There are instructions on adding a new mouse to the systemd dpi database here
- http://who-t.blogspot.com/2014/12/building-a-dpi-database-for-mice.html
- Summarised below
- Installation of some packages were required, found via `dnf provides`

- `sudo libinput list-devices`
```
Device:           Microsoft Microsoft Pro Intellimouse Mouse
Kernel:           /dev/input/event7
```

- For me, this mouse is `event7`
- Current setting can be confirmed with `udevadm info /dev/input/event7 | grep MOUSE_DPI`
- Initial fix gives: `E: MOUSE_DPI=1600@1000`

Measured via:
- `sudo mouse-dpi-tool /dev/input/event7`
- Distance travelled corresponded to roughly 51mm

To get pid, and vid:
- `lsusb`
- `Bus 001 Device 006: ID 045e:082a Microsoft Corp. Microsoft Pro Intellimouse`
- Given by `mouse-dpi-tool` anyway, but good confirmation

Re-measured after fix to 1600@1000
- After DPI set to 1600dpi, re-performed this test moving the mouse by approx
  50mm. Appears correct, as it corresponds to the entry:
    - `50mm	    1.98in	    1600dpi`
- `mouse-dpi-tool` suggested entry of:
```
mouse:usb:v045ep082a:name:Microsoft Microsoft Pro Intellimouse Mouse:
 MOUSE_DPI=XXX@1055
```
Suggested polling rate auto-detected to an average of 1055Hz, although internet lists 1000Hz as polling rate for this mouse. Using 1000Hz

Making recommended switch to local file : `/etc/udev/hwdb.d/71-mouse.hwdb`, and
removing our earlier fix from `/usr/lib/udev/hwdb.d/70-mouse.hwdb`
- Then regenerate hwdb and restart wayland (ie. logout or reboot)
- `sudo udevadm hwdb --update`
- `sudo udevadm trigger /dev/input/event7`

12/05/2021 22:18
- Added extra `*` to end of match string, to bring in line with comments and all
  other mice.
- Double check this works before submitting PR

### Summary

- Create local file `/etc/udev/hwdb.d/71-mouse.hwdb`

```
# - SW - 06/06/21
# Microsoft Intellimouse Pro
mouse:usb:v045ep082a:name:Microsoft Microsoft Pro Intellimouse Mouse:
 MOUSE_DPI=1600@1000
```

- `sudo udevadm hwdb --update`
- `sudo udevadm trigger /dev/input/event7`
- Restart wayland (logout / reboot)
- Check mouse DPI with 
- `udevadm info /dev/input/event7 | grep MOUSE_DPI`
- May have to install packages, was required for initial measurement

## Fedora 35

Workstation edition using gnome. Requires much less configuration than previous
instructions

### Install

- Rename root filesystem from `fedora_localhost-live` using GUI `disks` util.
    - Requires you be in a USB live boot session
    - Cannot use the same session as installation, because disk mounted and
      busy? Reboot into a 2nd USB live session after install
- Set hostname
    - `sudo hostnamectl set-hostname NEWHOSTNAME`
    - `hostnamectl`, to confirm
- Remove sudoers password
    - `sudo visudo`
        - `username ALL=(ALL) NOPASSWD: ALL`
        - `%groupname ALL=(ALL) NOPASSWD: ALL`
        - `%wheel ALL=(ALL) NOPASSWD: ALL`
- `sudo dnf install -y gnome-tweaks gnome-extensions-app vim vim-X11 htop tmux git gimp remmina xfce4-terminal`
    - Need both vim and vim-X11. Otherwise you get GVim only without
      `vim-enhanced` package
- Previous wallpapers:
    - Works back as far as Fedora 21, before the dnf package name format changes
      to codenames
    - `sudo dnf install -y f{27,28,29,30,32,34,35}-backgrounds-gnome`
    - Specify range with `..`, e.g. get everything since Fedora 21: `{21..35}`
    - `backgrounds-extras-gnome`, for other included stock wallpapers also

Can exclude the `extras` packages if not caring about supplemental wallpapers

```bash
sudo dnf install f{27,28,29,30,31,32,33,34,35,36}-backgrounds{,-extras}-gnome
sudo dnf install f{21..36}-backgrounds{,-extras}-gnome
# The good defaults:
sudo dnf install f{27,28,29,32,34,35,36}-backgrounds-gnome
```

### Make User Sudoer

- For additional users, first user should already be admin
- `sudo usermod -aG wheel username`

### Joining Kerberos Realm

Single sign on. Compatible with Microsoft Active Directory realms.

- All functionality built in, no packages needed
- Should name PC accordingly
    - E.g. `pcname.domainname`
        - So if domain is called `mydomain.local`, hostname is
          `pcname.mydomain.local`
- `realm discover`, list discoverable realms
- `realm list`, list currently joined realms
- `sudo realm join -v --user=admin NAME.LOCAL`
    - Join the realm named `NAME.LOCAL`, with the user credentials of user
      `admin`, `-v` verbose
    - Note: This user is used to add the machine to the realm, it must have
      permission to join new machines to the realm. It is not necessarily the
      user account you will use to log into the machine after joining.
- Allow these realm users to log in via this machine
    - `sudo realm permit -g 'mygroupname'`
        - Group `mygroupname`
    - `sudo realm permit user`
        - User `user`
- Login to realm account at `gdm` by using username format specified by `realm
  list`
    - Probably `user@domain`, `user@domain.local` etc.
- Persist user account at login screen by adding them in GNOME `Settings` ->
  `Users` -> `Add User` -> `Enterprise Login`

### Cockpit

- `sudo dnf install -y cockpit cockpit-pcp`
- `sudo systemctl enable cockpit.socket ; sudo systemctl start cockpit.socket`
- Access console:
    - `http://localhost:9090`, same machine
    - `https://pcname.local:9090/`
    - `http://ip-address-of-machine:9090/`

### SSH access

- `openssh-server` should already be installed, start it and enable it
    - `sudo systemctl enable sshd.service ; sudo systemctl start sshd.service`
- Send a key to machine
    - `ssh-copy-id user@hostname`
- [Disable password auth](README.md#disable-ssh-password-login)

### Thunar

- `sudo dnf install thunar tumbler`
    - Thunar is quite light, brings very few deps in especially if already
      switched to xfce4-terminal
    - Tumbler package generates image thumbnails automatically when entering a
      directory

### GNOME Tweaks

- Antialiasing: `Subpixel (for LCD screens)`
- Minimise and Maximise buttons
- Workspaces span displays
- Can map Caps Lock to ESC, and other useful rebinds in `Keyboard & Mouse` ->
  `Additional Layout Options`

### GNOME Extensions

- [GNOME Extensions](https://extensions.gnome.org/)
- `AppIndicator and KStatusNotifierItem Support`
    - Adds icon tray
- `Sound Input & Output Device Chooser`
- `Dash to Panel`
    - Windows 10 style bottom panel

### Automatic Updates

#### Install

- `sudo dnf install -y dnf-automatic`
- By editing and enabling the systemd timer `dnf-automatic-install.timer`
  instead of `dnf-automatic.timer` the default config at
  `/etc/dnf/automatic.conf` is overridden to act as though `apply_updates` is
  set to `yes`. Modify this config if updates not applied.
- By default this package runs updates every morning at 06:00
- SystemD timers will run later if a period is missed (ie. booted after 06:00)

#### Changing SystemD Timer Interval

- `sudo systemctl edit dnf-automatic-install.timer`
- Insert override contents between comments:

```yml
[Timer]
OnCalendar=
OnCalendar=Sat *-*-* 06:00
```

- Only lines you want to override from the default settings are included in this
  `override.conf` file. In our case the addition of `Sat` to `OnCalendar`, to
  apply on Saturdays at 06:00 instead of daily at 06:00
    - Need to first clear the variable to empty, or the override file had no effect
    - See [stack overflow](https://unix.stackexchange.com/questions/398540/how-to-override-systemd-unit-file-settings)
    - If this has no effect, can manually copy the default file
      `/usr/lib/systemd/system/dnf-automatic-install.timer` to
      `/etc/systemd/system/dnf-automatic-install.timer` and then modify contents

#### Enable and Verify

- `sudo systemctl enable dnf-automatic-install.timer ; sudo systemctl start dnf-automatic-install.timer`
- You can verify that the timer is active and scheduled for the correct time with
    - `sudo systemctl list-timers`, unit `dnf-automatic-install.timer`, or
    - `sudo systemctl status dnf-automatic-install.timer`
- If not `sudo systemctl daemon-reload` to reload

#### Logs

- `sudo journalctl -u dnf-automatic-install.service`
- `sudo systemctl status dnf-automatic-install.timer`

### Automatic Reboot

Good idea to reboot the system after updates, especially with new kernel versions frequently released. Can create a simple systemd timer to reboot weekly (Sundays 02:00) after dnf automatic runs on Saturdays

- Become root `sudo -i`
- `cd /etc/systemd/system`
- `vim schedule-reboot.timer`
    - `:set paste`
```yml
[Unit]
Description=Reboot Scheduling.

[Timer]
OnCalendar=Sun *-*-* 02:00
Unit=reboot.target

[Install]
WantedBy=timers.target
```
- `systemctl enable schedule-reboot.timer ; systemctl start schedule-reboot.timer`
    - Enable and start the new reboot timer
- `systemctl status schedule-reboot.timer ; systemctl list-timers`
    - Check it was correctly scheduled for Sunday 02:00, and that dnf automatic is set for Saturday

### Keyboard Shortcuts

- `Launchers`:
    - `Home folder` -> `Super+E`
        - File explorer - nautilus
        - Like Windows `Win+E` to launch File Explorer
        - **If not using nautilus, make a Custom Shortcut
    - `Launch web browser` -> `Super+W`
        Opens default browser
- `Navigation`:
    - `Switch windows` -> `Alt+Tab`
        - This fixes the default alt-tab behaviour to instead switch between all open windows as is common in Windows. By default alt-tab is actually Switch applications and groups all windows of an application together.
    - `Switch applications` -> `Super+Tab`
        - Sets `Super+Tab` to be what `Alt+Tab` used to be
- `Windows`:
    - `Hide window` -> `Alt+F9`
        - Match XFCE4 and some other Linux DEs
        - Minimises window, other shortcuts are already default: `Alt+F4` is close, `Alt+F7` is move, `Alt+F8` is resize, `Alt+F10` is maximise, `Alt+F11` is fullscreen
- `Custom Shortcuts`:
    - Firefox, private browsing mode:
        - Name: `Firefox Private Browsing`
        - Command: `firefox --private-window`
        - Shortcut: `Super+F`
    - Terminal
        - Name: `Terminal`
        - Command: `gnome-terminal` / `xfce4-terminal`
        - Shortcut: `Super+T` / `Ctrl+Alt+T`
    - GVim
        - Name: `GVim`
        - Command: `gvim`
        - Shortcut: `Super+G`
    - Thunar
        - Name: `Thunar`
        - Command: `thunar`
        - Shortcut: `Super+E`
    - Run Command
        - Have `Super+R` mapped to same run launcher as `Alt+F2`
        - `gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Alt>F2', '<Super>r']"`

### Other Settings

Can use `gsettings` to set some things on the CLI that cannot be set any other
way

- Screen timeout greater than 15 minutes
    - `gsettings set org.gnome.desktop.session idle-delay 1800`
        - Delay in seconds
        - I.e. 1800 seconds = 30 minutes
        - 0 = never
    - `gsettings set org.gnome.desktop.screensaver lock-delay 0`
        - Timeout to lock screen after blanking
        - 0 = instant

### TigerVNC

For remote working - like RDP for Linux

- `sudo dnf install tigervnc-server`
    - Includes also dependency `tigervnc-selinux`

### Forcing Dark Theme for legacy GTK apps

Dark theme for legacy GTK (i.e. gtk3 and older?) apps can be forced for all apps using GNOME Tweaks. But what if you want your system theme to remain globally light but force individual apps to dark?

GTK 4 apps usually have a toggle in their preferences for this already

Modified from https://unix.stackexchange.com/questions/14129/gtk-enable-set-dark-theme-on-a-per-application-basis

`GTK_THEME=Adwaita:dark xfce4-terminal`, directly in a terminal

#### .desktop launcher

Modify the `.desktop` launcher file used in the app menu and launchers

These are located in `/usr/share/applications/`, but will be overwritten on updates

Using `xfce4-terminal` as example

- Copy it to `~/.local/share/applications/`
- Modify line containing launch command `Exec=xfce4-terminal` to prepend with `env GTK_THEME=Adwaita:dark `
    - I.e. `Exec=env GTK_THEME=Adwaita:dark xfce4-terminal`

App should now launch with chosen theme when launched via shortcut (close all running instances first)

#### Keyboard shortcuts

Keyboard shortcuts usually launch the app directly, rather than going through the `.desktop` launcher

Prepend the same string onto the desired launch command in the keyboard shortcut e.g.

`xfce4-terminal` -> `env GTK_THEME=Adwaita:dark xfce4-terminal`

### Neovim & TreeSitter Plugin

Installed using "Plug"

#### Plug

- Install "plug" for neovim only:
    - https://github.com/junegunn/vim-plug
- As of 04/12/2022 00:41
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

- Add or use neovim plug line
```
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
```

- Reopen nvim
- Install plugs from `init.vim`
    - `:PlugInstall`, this should install TreeSitter

#### TreeSitter

- Install deps for adding TreeSitter parsers with `:TSInstall`
    - Currently `gcc`, `g++`, `libstdc++`
```
sudo dnf install -y gcc-g++ gcc
# Try static first, this was required and may be enough alone
sudo dnf install libstdc++-static
# If not this too, libstdc++ was already installed (f37) so tried devel headers first
sudo dnf install libstdc++-devel
```

- Install desired TreeSitter parsers
```
:TSInstall c
:TSInstall cpp
:TSInstall python
:TSInstall bash
```

- Enable highlighting in neovim `init.vim`
```
" At the bottom of your init.vim, keep all configs on one line
lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
```
