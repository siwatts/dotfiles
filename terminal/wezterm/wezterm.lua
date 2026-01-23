-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 125
config.initial_rows = 40

-- or, changing the font size and color scheme.
config.font_size = 13
config.font = wezterm.font 'IBM Plex Mono'
config.freetype_load_target = "HorizontalLcd"
config.display_pixel_geometry = "RGB"
--Deprecated:
--config.font_antialias = "Subpixel"

--config.color_scheme = 'Dracula (Official)'
config.color_scheme = 'Monokai (base16)'

--config.color_scheme = 'Cobalt2'
--config.color_scheme = 'Default (dark) (terminal.sexy)'
--config.color_scheme = 'DimmedMonokai'
--config.color_scheme = 'Eighties (dark) (terminal.sexy)'
--config.color_scheme = 'Horizon Dark (base16)'
--config.color_scheme = 'Ibm3270 (Gogh)'
--config.color_scheme = 'Jellybeans'
--config.color_scheme = 'Kanagawa (Gogh)'
--config.color_scheme = 'Molokai'
--config.color_scheme = 'Monokai (terminal.sexy)'
--config.color_scheme = 'MonokaiDark (Gogh)'
--config.color_scheme = 'nightfox'
--config.color_scheme = 'nord'
--config.color_scheme = 'Snazzy (Gogh)'
--config.color_scheme = 'Tomorrow (dark) (terminal.sexy)'
--config.color_scheme = 'Twilight (dark) (terminal.sexy)'
--config.color_scheme = 'Wombat'
--config.color_scheme = 'Zenburn'
--config.color_scheme = 'Zenburn (base16)'
--config.color_scheme = 'zenburn (terminal.sexy)'
--config.color_scheme = 'zenburned'

--config.color_scheme = 'GruvboxLight'
--config.color_scheme = 'Selenized Light (Gogh)'
--config.color_scheme = 'Tomorrow'

config.force_reverse_video_cursor = true

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- Finally, return the configuration to wezterm:
return config

