# About

You can control monitor brightness of certain monitors using a utility `ddccontrol`

Some simple scripts for this purpose

**Must manually check monitor is compatible and set device path**

# Quick Start

- Install util `ddccontrol`
- Probe monitors with `ddccontrol -p`
- Modify scripts with device paths of monitors
- Place `bin/` scripts in `/usr/local/bin` (multiuser)
- Create keyboard shortcuts for scripts

# Limitations

- Hardcoded to specific dual monitor set up
    - If monitors are identical remove 2nd monitor logic and simply call with single brightness arg as many times as req.
- Requires `sudo` for `ddccontrol` call, so either passwordless sudo for all or at least `ddccontrol` is required. In this case would have to replace `/usr/local/bin` paths with local `~/bin` paths in single user env.
