M = {}

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
    --["<leader>g"] = { "<CMD>Telescope live_grep<CR>", opt = { noremap = true } },
    ["<leader>ff"] = { "<CMD>Telescope find_files<CR>", opt = { noremap = true } },
    ["<leader>fg"] = {
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      opt = { noremap = true },
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
