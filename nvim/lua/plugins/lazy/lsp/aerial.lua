local spec = {
  'stevearc/aerial.nvim',
  enabled = true,
  opts = {
    backends = { 'lsp', 'treesitter' },
    manage_folds = true,
    filter_kind = false,
    keymaps = {
      ['k'] = 'actions.up_and_scroll',
      ['j'] = 'actions.down_and_scroll',
    },
  },
  -- Optional dependencies
  init = function()
    local utils = require('core.utils')
    local keymaps = require('core.keymaps')
    utils.load_mappings(keymaps['aerial'])
    utils.load_highlights('aerial')
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}

return spec
