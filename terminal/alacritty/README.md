# About

Alacritty terminal, 04/01/2026

# Config

```bash
ln -s alacritty.toml ~/.config/alacritty/
```

# Colours

Colorschemes in `alacritty-theme/` from [alacritty-theme on GitHub](https://github.com/alacritty/alacritty-theme)

Import into config with:

```toml
[general]
import = [
    "~/.config/alacritty/themes/themes/{theme}.toml"
]
```

Or manually copy paste contents of theme for overrides

