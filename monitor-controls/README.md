# About

You can control monitor brightness of certain monitors using a utility `ddccontrol`

Some simple scripts for this purpose

**Must manually check monitor is compatible and set device path**

# Quick Start

- Install util `ddccontrol`
    - Fedora: `sudo dnf install ddccontrol`
- Probe monitors with `ddccontrol -p`, noting device paths
- Place `bin/` scripts in `/usr/local/bin` (multiuser)
```
sudo cp -a monitor-controls/bin/. /usr/local/bin/
sudo chown root:root /usr/local/bin -R
ln -s /usr/local/bin/monitor-* $HOME/bin/
```
- Modify script `$HOME/bin/monitor-update.sh` with device paths of monitors
- Test and seed an initial value in terminal e.g. `monitor-update.sh 35`
- Create keyboard shortcuts
    - Monitor Up 10
        - `/usr/local/bin/monitor-adjust-up.sh 10`
        - `Super`+`=`
    - Monitor Down 10
        - `/usr/local/bin/monitor-adjust-down.sh 10`
        - `Super`+`-`
    - Monitor Up 5
        - `/usr/local/bin/monitor-adjust-up.sh 5`
        - `Super`+`Shift`+`=`
    - Monitor Down 5
        - `/usr/local/bin/monitor-adjust-down.sh 5`
        - `Super`+`Shift`+`-`
    - Monitor Current (Display current brightness setting)
        - `/usr/local/bin/monitor-current.sh`
        - `Super`+`0`
- Previously spawned `xfce4-terminal` for these keyboard shortcuts, can revert to this if `notify-send` does not work in future
    - E.g. `xfce4-terminal -e '/bin/bash -c "/usr/local/bin/monitor-adjust-up.sh; sleep 2s"'`

The adjust up and down scripts now take an integer argument of the amount to adjust the brightness by, allowing for multiple keyboard shortcuts to be set up with varying degrees of adjustment

# Limitations

- Hardcoded to specific dual monitor set up
    - If monitors are identical remove 2nd monitor logic and simply call with single brightness arg as many times as req.
- Requires `sudo` for `ddccontrol` call, so either passwordless sudo for all or at least `ddccontrol` is required. In this case would have to replace `/usr/local/bin` paths with local `~/bin` paths in single user env.

# Future

- There is a GNOME Extension which accomplishes this using the built in brightness slider?

