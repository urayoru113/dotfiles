return {
  -- https://github.com/m4xshen/hardtime.nvim
  'm4xshen/hardtime.nvim',
  lazy = false,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  keys = {
    { mode = 'n', '<leader>ht', function() vim.cmd('Hardtime toggle') end, desc = 'Toggle Hardtime' },
  },
  opts = {
    disable_mouse = false,
    disabled_filetypes = {
      'grug%-far*',
      'dap%-view*',
      'saga*',
      'codecompanion',
      'markdown',
      '',
    },
    disabled_keys = {
      ['<C-c>'] = { 'i' },
      ['<Up>'] = false,
      ['<Down>'] = false,
      ['<Left>'] = false,
      ['<Right>'] = false,
    },
    hints = {
      ['([web])%1%1%1'] = {
        message = function(keys)
          local key = keys:sub(4, 4)
          local message = 'You pressed the ' .. key .. ' key too many times!'
          if key == 'w' or key == 'e' then
            message = message .. ' Use f or t or s(flash.nvim) to find word'
          end
          if key == 'b' then
            message = message .. ' Use F or T or s(flash.nvim) to find word'
          end
          return message
        end,
        length = 4,
      },
      ['[fFtT][{([\'"<][kjlhwe]'] = {
        message = function(keys)
          return 'Use ' .. keys:sub(1, 1) .. '[letter] instead of ' .. keys
        end,
        length = 3,
      },
      ['0w'] = {
        message = function()
          return 'Use ^ instead of 0w'
        end,
        length = 2,
      },
      ['v%%[ydc]'] = {
        message = function(keys)
          return 'Use ' .. keys:sub(3, 3) .. '% instead of ' .. keys
        end,
        length = 3,
      },
      ['bce'] = {
        message = function(keys)
          return 'Use ciw instead of ' .. keys
        end,
        length = 3,
      },
    },
    callback = function(text)
      require('notify')(
        text,
        vim.log.levels.WARN,
        { title = 'Hardtime', timeout = 2000 }
      )
    end,
  },
}
