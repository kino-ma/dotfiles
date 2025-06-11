local act = wezterm.action

return {
  keys = {
    { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },
  },
  font = wezterm.font("Monaspace Neon"),
  font_size = 14.0,
  color_scheme = "Apple System Colors",
  colors = {
    foreground = "#c7c7c7"
  },

  initial_rows = 32,
  initial_cols = 128,

  font_rules = {
    {
      intensity = "Bold",
      font = wezterm.font(
        "Monaspace Neon",
        {
          foreground = "#fffeff",
          weight = "Bold",
        }
      )
    }
  },

  front_end = "WebGpu"
}

