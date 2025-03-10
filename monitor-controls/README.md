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
    - Monitor Up
        - `/usr/local/bin/monitor-adjust-up.sh`
        - `Super`+`=`
    - Monitor Down
        - `/usr/local/bin/monitor-adjust-down.sh`
        - `Super`+`-`
    - Monitor Current (Display current brightness setting)
        - `/usr/local/bin/monitor-current.sh`
        - `Super`+`0`
- Previously spawned `xfce4-terminal` for these keyboard shortcuts, can revert to this if `notify-send` does not work
    - E.g. `xfce4-terminal -e '/bin/bash -c "/usr/local/bin/monitor-adjust-up.sh; sleep 2s"'`


# Limitations

- Hardcoded to specific dual monitor set up
    - If monitors are identical remove 2nd monitor logic and simply call with single brightness arg as many times as req.
- Requires `sudo` for `ddccontrol` call, so either passwordless sudo for all or at least `ddccontrol` is required. In this case would have to replace `/usr/local/bin` paths with local `~/bin` paths in single user env.

# Future

- There is a GNOME Extension which accomplishes this using the built in brightness slider?

