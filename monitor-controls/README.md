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
        - `xfce4-terminal -e '/bin/bash -c "$HOME/bin/monitor-adjust-up.sh; sleep 2s"'`
        - `Super`+`=`
    - Monitor Down
        - `xfce4-terminal -e '/bin/bash -c "$HOME/bin/monitor-adjust-down.sh; sleep 2s"'`
        - `Super`+`-`
    - Monitor Reset
        - `$HOME/bin/monitor-daytime.sh`
        - `Super`+`0`
    - Monitor Current (spawns `xfce4-terminal` and briefly shows the current brightness)
        - `xfce4-terminal -e '/bin/bash -c "$HOME/bin/monitor-current.sh; sleep 2s"'`
        - `Super`+`KP/` (Numpad `/`)

# Limitations

- Hardcoded to specific dual monitor set up
    - If monitors are identical remove 2nd monitor logic and simply call with single brightness arg as many times as req.
- Requires `sudo` for `ddccontrol` call, so either passwordless sudo for all or at least `ddccontrol` is required. In this case would have to replace `/usr/local/bin` paths with local `~/bin` paths in single user env.

# Future

- There is a GNOME Extension which accomplishes this using the built in brightness slider?
