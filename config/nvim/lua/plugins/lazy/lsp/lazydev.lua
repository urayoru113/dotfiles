return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  dependencies = {
    {
      "DrKJeff16/wezterm-types",
      version = false, -- Get the latest version
    },
  },
  init = function()
    table.insert(require("plugins.config.blink").per_filetype.lua, "lazydev")
  end,
  --- @type lazydev.Config
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
  config = function(_, opts)
    require("lazydev").setup(opts)
  end,
}
