# Openbox

Openbox config file location, containing settings and keyboard shortcuts:
- `~/.config/openbox/rc.xml`

Install `obconf` and openbox themes.

## XFCE

To use openbox with a running xfce session (instead of xfwm4) use:
- `openbox --replace & exit`

To make this permanent, add as a startup program or replace the xfce executed
window manager.
- `Session and Startup` -> `Application Autostart`
    - Name: `Openbox`
    - Description: `Replace xfwm4 with openbox.`
    - Command: `openbox --replace`

## TODO

- Provided [rc.xml](rc.xml) file is for use with xfce4. Create a more generic
  one. Eg:
    - Volume key shortcuts
    - Menu conf
    - Application shortcuts

