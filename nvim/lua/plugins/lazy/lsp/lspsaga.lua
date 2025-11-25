local spec = {
  'nvimdev/lspsaga.nvim',
  opts = {
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
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  event = 'LspAttach'
}

return spec
