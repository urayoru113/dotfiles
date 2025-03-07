local utils = require('core.utils')
local options = {
  signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
}
local spec = {
  'lewis6991/gitsigns.nvim',
  opts = options,
  cmd = 'Gitsigns',
  init = function()
    utils.load_mappings("gitsigns")
  end,
}

return spec
