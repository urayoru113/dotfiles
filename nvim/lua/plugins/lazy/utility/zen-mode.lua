local utils = require('core.utils')
local keymaps = require('core.keymaps')
return {
  --https://github.com/folke/zen-mode.nvim
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  init = function()
    utils.load_mappings(keymaps['zen-mode'])
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    window = {
      options = {
        signcolumn = 'no',     -- disable signcolumn
        number = true,         -- disable number column
        relativenumber = true, -- disable relative numbers
        cursorline = false,    -- disable cursorline
        cursorcolumn = false,  -- disable cursor column
        foldcolumn = '0',      -- disable fold column
        list = false,          -- disable whitespace characters
      },
    },
    plugins = {
      optsions = {
        laststatus = 3,
      },
    },
  },
}
