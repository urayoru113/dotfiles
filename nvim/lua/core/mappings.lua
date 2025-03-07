M = {}

local _, gitsigns = pcall(require, "gitsigns")

M.general = {
  n = {
    ["<C-s>"] = { "<CMD>w<CR>", opt = { noremap = true } },
    ["<C-h>"] = { "<C-w>h" },
    ["<C-j>"] = { "<C-w>j" },
    ["<C-k>"] = { "<C-w>k" },
    ["<C-l>"] = { "<C-w>l" },
    ["<tab>"] = { "gt" },
    ["<s-tab>"] = { "gT" },
    ["/"] = { "ms/" },
    ["?"] = { "ms?" },
    ["Q"] = { "<CMD>q<CR>", opt = { noremap = true } },
    ["<C-q>"] = {
      function()
        if vim.fn.tabpagenr("$") > 1 then
          return "<CMD>tabclose<CR>"
        else
          return "<CMD>qall<CR>"
        end
      end,
      opt = { noremap = true, expr = true },
    },
    ["<F6>"] = { "<CMD>ToggleDebugMode<CR>" },
  },

  ["!"] = {
    ["<C-c>"] = { "<Esc>", opt = { noremap = true } },
    ["<C-l>"] = { "<Delete>" },
  },

  [""] = {
    ["<C-c>"] = { "<Esc>", opt = { noremap = true } },
  },

  t = {
    ["<C-h>"] = { "<C-w>h" },
    ["<C-j>"] = { "<C-w>j" },
    ["<C-k>"] = { "<C-w>k" },
    ["<C-l>"] = { "<C-w>l" },
  },
}

M["nvim-tree"] = {
  n = {
    ["<F2>"] = {
      function()
        return "<CMD>silent NvimTreeToggle<CR>"
      end,
      opt = { noremap = true, expr = true },
    },
  },
}

M.cocnvim = {
  n = {
    ["<C-n>"] = { "<Plug>(coc-cursors-word)g*", opt = { noremap = true } },
    ["<leader><leader>"] = { "<Plug>(coc-cursors-position)", opt = { noremap = true } },
    ["<leader>F"] = {
      function()
        vim.fn.CocAction("format")
      end,
      opt = { noremap = true },
    },
    ["[g"] = { "<Plug>(coc-diagnostic-prev)", opt = { noremap = true, silent = true } },
    ["]g"] = { "<Plug>(coc-diagnostic-next)", opt = { noremap = true, silent = true } },
  },
  x = {
    ["<C-n>"] = { "y/\\V<C-r>=escape(@\", '/\\')<CR><CR>Ngn<Plug>(coc-cursors-range)ngn", opt = { noremap = true } },
  },
  i = {
    ["<C-y>"] = {
      [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      opt = { noremap = true, silent = true, expr = true, replace_keycodes = false },
    },
  },
}

M.aerial = {
  n = {
    ["<F8>"] = { "<cmd>AerialToggle!<CR>", opt = { noremap = true, silent = true } },
  },
}

M.lspsaga = {
  n = {
    ["K"] = { "<CMD>Lspsaga hover_doc<CR>" },
    ["gd"] = { "<CMD>Lspsaga goto_definition<CR>" },
    ["<leader>lf"] = { "<CMD>Lspsaga finder<CR>" },
    ["<leader>rn"] = { function() vim.lsp.buf.rename() end },
    ["gj"] = { "<CMD>Lspsaga diagnostic_jump_next<CR>" },
    ["gk"] = { "<CMD>Lspsaga diagnostic_jump_prev<CR>" },
    ["gp"] = { "<CMD>Lspsaga peek_definition<CR>" },
    ["gi"] = { "<CMD>Lspsaga incoming_calls<CR>" },
    ["go"] = { "<CMD>Lspsaga outgoing_calls<CR>" },
    ["<leader>a"] = { "<CMD>Lspsaga code_action<CR>" },
    ["<leader>o"] = { "<CMD>Lspsaga outline<CR>" },
    ["<leader>F"] = { function() vim.lsp.buf.format({ async = true }) end
    },
  }
}

M.lsp = {
  n = {
    ["K"] = { vim.lsp.buf.hover },
    ["<leader>F"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
    },
    ["<leader>a"] = {
      function()
        vim.lsp.buf.code_action()
      end,
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition({ reuse_win = false })
      end,
    },
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
    },
    ["gI"] = {
      function()
        vim.lsp.buf.implementation()
      end,
    },
    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
    },
    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
    },
    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
    },
    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
    },
    ["<leader>rn"] = {
      function()
        vim.lsp.buf.rename()
      end,
    },
    ["gj"] = {
      function()
        vim.diagnostic.goto_next()
      end,
    },
    ["gk"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
    },
  },
}

M.toggleterm = {}

M.telescope = {
  n = {
    ["<leader>ff"] = { "<CMD>Telescope find_files<CR>", opt = { noremap = true } },
    ["<leader>fg"] = {
      function()
        if vim.fn.executable("rg") == 1 then
          return "<CMD>Telescope live_grep_args<CR>"
        else
          return "<CMD>Telescope live_grep<CR>"
        end
      end,
      --":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      opt = { noremap = true, expr = true },
    },
  },
}

M.dap = {
  n = {
    ["<M-d>b"] = { "<CMD>DapToggleBreakpoint<CR>" },
    ["<M-d>c"] = { "<CMD>DapContinue<CR>" },
    ["<M-d>t"] = { "<CMD>DapTerminate<CR>" },
    ["<M-d>i"] = { "<CMD>DapStepInto<CR>" },
    ["<M-d>o"] = { "<CMD>DapStepOut<CR>" },
    ["<M-d>v"] = { "<CMD>DapStepOver<CR>" },
    ["<M-d>s"] = { "<CMD>DapShowLog<CR>" },
  },
}

M["markdown-preview"] = {
  n = {
    ["<F9>"] = { "<CMD>MarkdownPreviewToggle<CR>", opt = { noremap = true } },
  },
}

M.gitsigns = {
  n = {
    ["]c"] = {
      function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end,
      opt = { noremap = true }
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end,
      opt = { noremap = true }
    },
    ["<leader>hd"] = {
      "<CMD>Gitsigns diffthis HEAD vertical=true<CR>"
    }
  }
}

M.python = {
  n = {
    ["<F9>"] = { "<CMD>!python %<CR>", opt = { noremap = true } },
  },
}

M.c = {
  n = {
    ["<F9>"] = { "<CMD>!gcc %:p -o %:p:r && %:p:r<CR>", opt = { noremap = true, silent = true } },
  },
}

M.cpp = {
  n = {
    ["<F9>"] = { "<CMD>!g++ %:p -o %:p:r && %:p:r<CR>", opt = { noremap = true, silent = true } },
  },
}

return M
