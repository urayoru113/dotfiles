local options = {
  ensure_installed = {
    "vimdoc",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}

local spec = {
  "nvim-treesitter/nvim-treesitter",
  opts = options,
  build = ":TSUpdate",
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return spec
