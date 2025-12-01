return {
  --https://github.com/folke/edgy.nvim
  'folke/edgy.nvim',
  opts = {
    keys = {
      -- close window
      ['Q'] = function(win)
        if vim.fn.tabpagenr('$') == 1 and vim.fn.winnr('$') == 1 then
          vim.cmd('q')
        else
          win:close()
        end
      end,
      -- hide window
      ['<c-q>'] = false, -- win:hide()
      -- close sidebar
      -- ['Q'] = function(win)
      --   win.view.edgebar:close()
      -- end,
      -- next open window
      [']w'] = function(win)
        win:next({ visible = true, focus = true })
      end,
      -- previous open window
      ['[w'] = function(win)
        win:prev({ visible = true, focus = true })
      end,
      -- next loaded window
      [']W'] = function(win)
        win:next({ pinned = false, focus = true })
      end,
      -- prev loaded window
      ['[W'] = function(win)
        win:prev({ pinned = false, focus = true })
      end,
      -- increase width
      ['<c-w>>'] = function(win)
        win:resize('width', 2)
      end,
      -- decrease width
      ['<c-w><lt>'] = function(win)
        win:resize('width', -2)
      end,
      -- increase height
      ['<c-w>+'] = function(win)
        win:resize('height', 2)
      end,
      -- decrease height
      ['<c-w>-'] = function(win)
        win:resize('height', -2)
      end,
      -- reset all custom sizing
      ['<c-w>='] = function(win)
        win.view.edgebar:equalize()
      end,
    },
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = 'Neo-Tree',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'filesystem'
        end,
        size = { height = 0.5 },
      },
    },
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = 'dap-view',
        size = { height = 0.3 },
      },
    },
    right = {
      {
        ft = 'grug-far',
        size = { height = 0.5, width = 0.3 },
      },
    },
    animate = {
      enabled = false,
    },
  },
}
