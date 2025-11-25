local utils = require('core.utils')
local keymaps = require('core.keymaps')

local spec = {
  'lewis6991/gitsigns.nvim',
  cond = function()
    local found_paths = vim.fs.find(
      '.git',
      {
        upward = true,
        limit = 1,
        type = 'directory',
      }
    )
    return #found_paths > 0
  end,
  opts =
  {
    signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  },
  cmd = {'Gitsigns'},
  init = function()
    utils.load_mappings(keymaps['gitsigns'])
  end,
}

return spec
