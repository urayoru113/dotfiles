M = {}

M.general = {
  n = {
    {
      lhs = '<C-s>',
      rhs = '<cmd>w<CR>',
      opt = { noremap = true },
    },
    {
      lhs = '<C-d>',
      rhs = 'yyp',
    },
    {
      lhs = '<C-h>',
      rhs = '<C-w>h',
    },
    {
      lhs = '<C-j>',
      rhs = '<C-w>j',
    },
    {
      lhs = '<C-k>',
      rhs = '<C-w>k',
    },
    {
      lhs = '<C-l>',
      rhs = '<C-w>l',
    },
    {
      lhs = '<tab>',
      rhs = 'gt',
    },
    {
      lhs = '<s-tab>',
      rhs = 'gT',
    },
    {
      lhs = '/',
      rhs = 'ms/',
    },
    {
      lhs = '?',
      rhs = 'ms?',
    },
    {
      lhs = 'Q',
      rhs = function()
        if vim.fn.tabpagenr('$') > 1 then
          return "<CMD>tabclose<CR>"
        else
          return "<CMD>qall<CR>"
        end
      end,
      opt = { noremap = true, expr = true },
    },
  },

  i = {
    {
      lhs = '<C-c>',
      rhs = '<Esc>',
    },
  },

  [""] = {
    {
      lhs = '<C-c>',
      rhs = '<Esc>',
    },
  },

  t = {
    {
      lhs = '<C-h>',
      rhs = '<C-w>h',
    },
    {
      lhs = '<C-j>',
      rhs = '<C-w>j',
    },
    {
      lhs = '<C-k>',
      rhs = '<C-w>k',
    },
    {
      lhs = '<C-l>',
      rhs = '<C-w>l',
    },
  }
}

M.nvimtree = {
  n = {
    {
      lhs = '<F2>',
      rhs = function()
        return '<CMD>NvimTreeToggle<CR>'
      end,
      opt = { noremap = true, expr = true },
    }
  }
}

M.cocnvim = {
  n = {
    {
      lhs = '<C-n>',
      rhs = '<Plug>(coc-cursors-word)g*',
      opt = { noremap = true }
    },
    {
      lhs = '<leader><leader>',
      rhs = '<Plug>(coc-cursors-position)',
      opt = { noremap = true }
    },
    {
      lhs = '<leader>f',
      rhs = function()
        vim.fn.CocAction('format')
      end,
      opt = { noremap = true }
    },
    {
      lhs = '[g',
      rhs = '<Plug>(coc-diagnostic-prev)',
      opt = { noremap = true, silent = true }
    },
    {
      lhs = ']g',
      rhs = '<Plug>(coc-diagnostic-next)',
      opt = { noremap = true, silent = true }
    },
  },
  x = {
    {
      lhs = '<C-n>',
      rhs = 'y/\\V<C-r>=escape(@", \'/\\\')<CR><CR>Ngn<Plug>(coc-cursors-range)ngn',
      opt = { noremap = true }
    }
  },
  i = {
    {
      lhs = '<C-y>',
      rhs = [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      opt = { noremap = true, silent = true, expr = true, replace_keycodes = false }
    }
  }
}

M.aerial = {
  n = {
    {
      lhs = '<F8>',
      rhs = '<cmd>AerialToggle!<CR>',
      opt = { noremap = true, silent = true }
    }
  }
}

M.toggleterm = {
}

M.python = {
  n = {
    {
      lhs = '<F9>',
      rhs = '<CMD>!python %<CR>',
      opt = { noremap = true }
    }
  }
}

M.c = {
  n = {
    {
      lhs = '<F9>',
      rhs = '<CMD>!gcc %:p -o %:p:r && %:p:r<CR>',
      opt = { noremap = true, silent = true }
    }
  }
}

M.cpp = {
  n = {
    {
      lhs = '<F9>',
      rhs = '<CMD>!g++ %:p -o %:p:r && %:p:r<CR>',
      opt = { noremap = true, silent = true }
    }
  }
}
return M
