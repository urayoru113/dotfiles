local plugins = {
  { import = "plugins.lazy" },
  { import = "plugins.lazy.lsp" },
  { import = "plugins.lazy.colorschemes" },
}

local options = {
  install = {
    colorscheme = { "moonlight", "tokyonight", "slate" },
  },
  change_detection = {
    notify = false,
    enabled = true,
  },
}

require("lazy").setup(plugins, options)
require("plugins.lsp").setup()

vim.api.nvim_command("colorscheme tokyonight")
