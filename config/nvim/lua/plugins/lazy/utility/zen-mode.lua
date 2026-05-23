local keymaps = require('core.keymaps')
return {
  --https://github.com/folke/zen-mode.nvim
  enabled = false,
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  keys = keymaps['zen-mode'],
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
