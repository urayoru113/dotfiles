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
      words = { enabled = false },
      image = { enabled = false },
    }
  end,
  keys = function()
    local snacks = require('snacks')
    return {
      { '<leader>lg', function() snacks.lazygit.open() end, desc = 'LazyGit' }
    }
  end,
}
