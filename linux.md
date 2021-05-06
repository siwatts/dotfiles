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
