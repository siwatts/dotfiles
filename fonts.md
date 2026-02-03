# About

Font rendering, GTK / QT differences etc.

# Stem thickening

Can get something slightly closer to Fedora's QT rendering in GTK applications with the following (launching `xterm` for example):

```bash
env FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0" xterm
```

Call this in a terminal or prepend it to a desktop shortcut launcher `Exec=` command

This could be made permanent (and apply everywhere!) by addition to the file `/etc/environment`, sourced from [this blogpost](https://blog.aktsbot.in/no-more-blurry-fonts.html)

```
FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"
```

There are probably better ways of doing this though... Fedora font configuration lives in `/etc/fonts/conf.d/`, `/etc/fonts/fonts.conf` and can be overridden with local config files. Anyway it is probably not a good idea to do this permanently or globally as it affects everything and font rendering is often changing

# Subpixel rgb / GTK4

Subpixel rgb is removed as of gtk4, so no gtk4/libadwaita app will have it. This means programs like ptyxis, gnome-text-editor and so on. Xfce apps are gtk3 and continue to have it

For legacy X11 applications like xterm/(u)rxvt `Xft` is used, e.g. in `~/.Xresources` we can control antialiasing and hinting

```
! General font settings
! These are set by xfce, but we can set explicitly here if needed
Xft.antialias:  1
Xft.dpi:        96
Xft.hinting:    1
Xft.hintstyle:  hintslight
Xft.rgba:       rgb
```

Often desktop environments or distributions like Fedora will set or override these themselves, so these settings are effectively ignored. However it may be required on other distros or OS like FreeBSD

# Hinting

On Fedora 43 (Xfce 4.20) `slight` hinting with subpixel rgb enabled is a good compromise

Fonts like `DejaVu Sans Mono` are particularly affected by `full` hinting and end up oddly shaped (but sharp)

# Fonts

- Source Code Pro
- IBM Plex Mono

With the font rendering in Fedora 43 (Xfce 4.20) gtk applications these can be very thin or hard to read (or too thick and blurry in Medium weight)

So some good fallback fonts are:

- Liberation Mono
- DejaVu Sans Mono
- Hack
- Noto Sans Mono (named Monospace in Fedora)
- Adwaita (Iosevka variant created by GNOME)
- Cascadia Mono (MS Windows)

Bonus:

- Red Hat Mono
- Fira
- Roboto Mono
- Droid Sans Mono
- Terminus

