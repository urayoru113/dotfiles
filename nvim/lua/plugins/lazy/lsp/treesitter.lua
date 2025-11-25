local spec = {
  'nvim-treesitter/nvim-treesitter',
  opts = {
    ensure_installed = {
      'vimdoc',
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = false,
    },
    endwise = {
      enable = true -- for neovim < 0.9
    }
  },
  build = ':TSUpdate',
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}

return spec
