-- OPTIMIZE: This method should be refactor
M = {}

M.general = {
  n = {
    ['<C-s>'] = { '<CMD>w<CR>', opts = { noremap = true, desc = 'Save file' } },
    ['<C-h>'] = { '<C-w>h' },
    ['<C-j>'] = { '<C-w>j' },
    ['<C-k>'] = { '<C-w>k' },
    ['<C-l>'] = { '<C-w>l' },
    ['<tab>'] = { 'gt' },
    ['<s-tab>'] = { 'gT' },
    ['/'] = { 'ms/', opts = { noremap = true } },
    ['?'] = { 'ms?', opts = { noremap = true } },
    ['Q'] = { '<CMD>q<CR>', opts = { noremap = true, desc = 'Quit' } },
    ['<C-q>'] = {
      function()
        if vim.fn.tabpagenr('$') > 1 then
          return '<CMD>tabclose<CR>'
        else
          return '<CMD>qall<CR>'
        end
      end,
      opts = { noremap = true, expr = true, desc = 'Close tab' },
    },
    ['<C-t>'] = {
      function()
        local word = vim.fn.expand('<cword>')
        local revert = {
          ['true'] = 'false',
          ['false'] = 'true',
          ['True'] = 'False',
          ['False'] = 'True',
        }
        if revert[word] ~= nil then
          return 'ciw' .. revert[word] .. '<ESC>b'
        end
        return ''
      end,
      opts = { expr = true },
    },
  },

  ['!'] = {
    ['<C-l>'] = { '<Delete>' },
  },

  [''] = {
  },

  t = {
    ['<C-h>'] = { '<C-w>h' },
    ['<C-j>'] = { '<C-w>j' },
    ['<C-k>'] = { '<C-w>k' },
    ['<C-l>'] = { '<C-w>l' },
  },
}

M['nvim-tree'] = {
  n = {
    ['<F2>'] = { '<CMD>NvimTreeToggle<CR>', opts = { noremap = true } },
  },
}

M.cocnvim = {
  n = {
    ['<C-n>'] = { '<Plug>(coc-cursors-word)g*', opts = { noremap = true } },
    ['<leader><leader>'] = { '<Plug>(coc-cursors-position)', opts = { noremap = true } },
    ['<leader>F'] = {
      function()
        vim.fn.CocAction('format')
      end,
      opts = { noremap = true, desc = 'Format' },
    },
    ['[g'] = { '<Plug>(coc-diagnostic-prev)', opts = { noremap = true, silent = true } },
    [']g'] = { '<Plug>(coc-diagnostic-next)', opts = { noremap = true, silent = true } },
  },
  x = {
    ['<C-n>'] = { "y/\\V<C-r>=escape(@\", '/\\')<CR><CR>Ngn<Plug>(coc-cursors-range)ngn", opts = { noremap = true } },
  },
  i = {
    ['<C-y>'] = {
      [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      opts = { noremap = true, silent = true, expr = true, replace_keycodes = false },
    },
  },
}

M.aerial = {
  n = {
    ['<F8>'] = { '<cmd>AerialToggle!<CR>', opts = { noremap = true, silent = true } },
  },
}

M.lspsaga = {
  n = {
    ['K'] = { '<CMD>Lspsaga hover_doc<CR>' },
    ['grd'] = { '<CMD>Lspsaga goto_definition<CR>' },
    ['grf'] = { '<CMD>Lspsaga finder<CR>' },
    ['grn'] = { function() vim.lsp.buf.rename() end, opts = { desc = 'Rename' } },
    ['gj'] = { '<CMD>Lspsaga diagnostic_jump_next<CR>' },
    ['gk'] = { '<CMD>Lspsaga diagnostic_jump_prev<CR>' },
    ['grp'] = { '<CMD>Lspsaga peek_definition<CR>' },
    ['gri'] = { '<CMD>Lspsaga incoming_calls<CR>' },
    ['gro'] = { '<CMD>Lspsaga outgoing_calls<CR>' },
    ['gra'] = { '<CMD>Lspsaga code_action<CR>' },
    ['grO'] = { '<CMD>Lspsaga outline<CR>' },
    ['<leader>F'] = { function() vim.lsp.buf.format({ async = true }) end, opts = { desc = 'Format' } },
  },
}

M.lsp = {
  n = {
    ['K'] = { vim.lsp.buf.hover },
    ['<leader>F'] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
    },
    ['<leader>a'] = {
      function()
        vim.lsp.buf.code_action()
      end,
    },
    ['gd'] = {
      function()
        vim.lsp.buf.definition({ reuse_win = false })
      end,
    },
    ['gD'] = {
      function()
        vim.lsp.buf.declaration()
      end,
    },
    ['gI'] = {
      function()
        vim.lsp.buf.implementation()
      end,
    },
    ['gr'] = {
      function()
        vim.lsp.buf.references()
      end,
    },
    ['<leader>wa'] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
    },
    ['<leader>wr'] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
    },
    ['<leader>wl'] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
    },
    ['<leader>rn'] = {
      function()
        vim.lsp.buf.rename()
      end,
    },
    ['gj'] = {
      function()
        vim.diagnostic.jump({ count = 1 })
      end,
    },
    ['gk'] = {
      function()
        vim.diagnostic.jump({ count = -1 })
      end,
    },
  },
}

M.telescope = {
  n = {
    ['<leader>fc'] = { '<CMD>Telescope colorscheme enable_preview=true<CR>', opts = { noremap = true, desc = 'Colorscheme with preview' } },
    ['<leader>ff'] = { '<CMD>Telescope find_files<CR>', opts = { noremap = true, desc = 'Find files' } },
    ['<leader>fk'] = { '<CMD>Telescope keymaps<CR>', opts = { noremap = true, desc = 'Find keymaps' } },
    ['<leader>fd'] = { '<CMD>Telescope diagnostics<CR>', opts = { noremap = true, desc = 'Find diagnostic' } },
  },
}

M.gitsigns = function()
  local gitsigns = require('gitsigns')
  return {
    n = {
      ['<leader>gn'] = {
        function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end,
        opts = { noremap = true },
      },
      ['<leader>gp'] = {
        function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end,
        opts = { noremap = true },
      },
      ['<leader>gd'] = {
        '<CMD>Gitsigns diffthis HEAD vertical=true<CR>',
      },
    },
  }
end

M.luasnip = function()
  local ls = require('luasnip')
  return {
    i = {
      ['<TAB>'] = { function() ls.jump(1) end, { silent = true } },
      ['<s-TAB>'] = { function() ls.jump(-1) end, { silent = true } },
    },
  }
end

M['grug-far'] = function()
  local grug_far = require('grug-far')
  return {
    n = {
      ['<leader>S'] = {
        function()
          grug_far.open()
        end,
        opts = {
          desc = 'Open grug-far',
        },
      },
    },
    v = {
      ['<leader>S'] = {
        function()
          grug_far.open({
            startInInsertMode = false,
          })
        end,
        opts = {
          desc = 'Open grug-far',
        },
      },
    },
  }
end

M.debug_mode = {
  n = {
    ['<F6>'] = { '<CMD>ToggleDebugMode<CR>', opts = { desc = 'Toggle debug mode' } },
  },
}

M.dap = {
  n = {
    ['<leader>df'] = { '<CMD>ToggleDebugKeymap<CR>', opts = { desc = 'Toggle debug keymap' } },
    ['<leader>db'] = { '<CMD>DapToggleBreakpoint<CR>' },
    ['<leader>dc'] = { '<CMD>DapContinue<CR>' },
    ['<leader>dt'] = { '<CMD>DapTerminate<CR>' },
    ['<leader>di'] = { '<CMD>DapStepInto<CR>' },
    ['<leader>do'] = { '<CMD>DapStepOut<CR>' },
    ['<leader>dv'] = { '<CMD>DapStepOver<CR>' },
    ['<leader>ds'] = { '<CMD>DapShowLog<CR>' },
  },
}

M.fastdap = {
  n = {
    ['b'] = { '<CMD>DapToggleBreakpoint<CR>' },
    ['c'] = { '<CMD>DapContinue<CR>' },
    ['t'] = { '<CMD>DapTerminate<CR>' },
    ['i'] = { '<CMD>DapStepInto<CR>' },
    ['o'] = { '<CMD>DapStepOut<CR>' },
    ['v'] = { '<CMD>DapStepOver<CR>' },
    ['s'] = { '<CMD>DapShowLog<CR>' },
  },
}

M['zen-mode'] = {
  n = {
    ['Z'] = { '<CMD>ZenMode<CR>' },
  },
}

M.python = {
  n = {
    ['<F9>'] = { '<CMD>!python %<CR>', opts = { noremap = true, ft = 'python' } },
  },
}

M.lua = {
  n = {
    ['<F9>'] = { '<CMD>!lua %<CR>', opts = { noremap = true, silent = true, ft = 'lua' } },
  },
}

M.c = {
  n = {
    ['<F9>'] = { '<CMD>!gcc %:p -o %:p:r && %:p:r<CR>', opts = { noremap = true, silent = true, ft = 'c' } },
  },
}

M.cpp = {
  n = {
    ['<F9>'] = { '<CMD>!g++ %:p -o %:p:r && %:p:r<CR>', opts = { noremap = true, silent = true, ft = 'cpp' } },
  },
}

M.sh = {
  n = {
    ['<F9>'] = { '<CMD>!%:p<CR>', opts = { noremap = true, silent = true, ft = { 'sh' } } },
  },
}


return M
