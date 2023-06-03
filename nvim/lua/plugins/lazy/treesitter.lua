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
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
  end,
}

return spec
