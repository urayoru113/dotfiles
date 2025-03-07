local options = {
  lightbulb = {
    enable = false,
  },
  symbol_in_winbar = {
    show_file = false,
  },
  rename = {
    auto_save = true
  },
  hover = {
    open_cmd = '!google-chrome',
  },
}

local spec = {
  'nvimdev/lspsaga.nvim',
  opts = options,
  config = function(_, opts)
    require('lspsaga').setup(opts)
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  event = 'LspAttach'
}

return spec
