-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font =
  wezterm.font('JetBrains Mono', { weight = 'Light', italic = false })
config.font_size = 12.0
config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'Hack', weight = 'Bold' },

  -- The size of the font in the tab bar.
  font_size = 11.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = '#333333',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  },
}

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'ayu'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'ayu'
  else
    return 'ayu_light'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

-- and finally, return the configuration to wezterm
return config
