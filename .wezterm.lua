---@diagnostic disable: undefined-global
-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

config.default_prog = { "wsl.exe", "-d", "Ubuntu-20.04" }
config.initial_cols = 120
config.initial_rows = 28
config.window_close_confirmation = "NeverPrompt"
config.skip_close_confirmation_for_processes_named = {
  -- Linux process
  "bash", "sh", "zsh", "fish",
  -- Windows process
  "cmd.exe", "powershell.exe", "pwsh.exe", "wsl.exe", "wslhost.exe", "conhost.exe",
}

-- background
config.background = {
  {
    source = { File = "C:/Users/hdhr1/Pictures/background/4k-anime-space-17i9z99mtqn95i9i.jpg" },
    opacity = 0.95,
    hsb = { brightness = 0.4 },
  },
}

config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString "\x0a" },
  { key = "v", mods = "CTRL|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "s", mods = "CTRL|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "LeftArrow", mods = "CTRL|ALT", action = act.MoveTabRelative(-1) },
  { key = "RightArrow", mods = "CTRL|ALT", action = act.MoveTabRelative(1) },
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = act.MoveTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = act.MoveTabRelative(1),
  },
}

wezterm.font("")
config.font = wezterm.font_with_fallback({
  { family = "MesloLGL Nerd Font", weight = "Regular", style = "Normal" },
  { family = "FiraCode Nerd Font", weight = "DemiBold" },
  { family = "JetBrains Mono", weight = "ExtraLight" },
})

config.mouse_bindings = {
  {
    event = { Drag = { streak = 1, button = "Left" } },
    mods = "CTRL|SHIFT",
    action = act.StartWindowDrag,
  },
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom "Clipboard",
  },
}

return config
