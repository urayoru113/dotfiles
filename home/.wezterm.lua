---@diagnostic disable: undefined-global
-- Pull in the wezterm API
local wezterm = require("wezterm") ---@type Wezterm

-- This will hold the configuration.
local config = wezterm.config_builder() ---@type Config

local act = wezterm.action

config.launch_menu = {
  {
    label = "Arch Linux (WSL)",
    args = { "wsl.exe", "-d", "archlinux", "-u", "urayoru" },
  },
  {
    label = "Ubuntu (WSL)",
    args = { "wsl.exe", "-d", "Ubuntu-20.04" },
  },
  {
    label = "PowerShell",
    args = { "powershell.exe", "-NoLogo" },
  },
  {
    label = "Command Prompt (CMD)",
    args = { "cmd.exe" },
  },
}
config.default_prog = { "wsl.exe", "-d", "archlinux", "-u", "urayoru" }
config.initial_cols = 120
config.initial_rows = 28
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = true
config.skip_close_confirmation_for_processes_named = {
  -- Linux process
  "bash",
  "sh",
  "zsh",
  "fish",
  -- Windows process
  "cmd.exe",
  "powershell.exe",
  "pwsh.exe",
  "wsl.exe",
  "wslhost.exe",
  "conhost.exe",
}

-- background
config.background = {
  {
    source = { File = "C:/Users/hdhr1/Pictures/background/thumb-1920-829704.png" },
    opacity = 0.95,
    hsb = { brightness = 0.4 },
  },
}

config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x0a") },
  { key = "v", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "s", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "LeftArrow", mods = "CTRL|ALT", action = act.MoveTabRelative(-1) },
  { key = "RightArrow", mods = "CTRL|ALT", action = act.MoveTabRelative(1) },
  --- switch pane
  { key = "h", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Down") },
}

config.font = wezterm.font_with_fallback({
  { family = "MesloLGL Nerd Font", weight = "Regular", style = "Normal" },
  { family = "FiraCode Nerd Font", weight = "DemiBold" },
  { family = "JetBrains Mono", weight = "ExtraLight" },
})

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Drag = { streak = 1, button = "Left" } },
    mods = "CTRL|SHIFT",
    action = act.StartWindowDrag,
  },
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.PasteFrom("Clipboard"),
  },
}

return config
