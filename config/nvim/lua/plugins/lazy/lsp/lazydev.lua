return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  dependencies = {
    {
      "DrKJeff16/wezterm-types",
      version = false, -- Get the latest version
    },
  },
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
