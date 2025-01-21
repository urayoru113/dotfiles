local options = {
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
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
  end,
}

return spec
