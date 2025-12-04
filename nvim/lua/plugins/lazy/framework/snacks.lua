-- https://github.com/folke/snacks.nvim
return {
  'folke/snacks.nvim',
  cond = true,
  lazy = false,
  opts = function()
    return {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      image = { enabled = false },
      zen = {
        show = {
          statusline = true, -- can only be shown when using the global statusline
          tabline = false,
        },
      },
    }
  end,
  keys = function()
    local snacks = require('snacks')
    return {
      { '<leader>gl', function() snacks.lazygit.open() end, desc = 'LazyGit' },
      { mode = { 'n', 'o' }, 'gw', function() snacks.words.jump(1, true) end, desc = 'Go to next lsp word' },
      { mode = { 'n', 'o' }, 'gW', function() snacks.words.jump(-1, true) end, desc = 'Go to prev lsp word' },
      { 'Z', function() snacks.zen.zen() end, desc = 'Zen mode' },
      { '<leader>z', function() snacks.zen.zoom() end, desc = 'Zoom mode' },
    }
  end,
}
