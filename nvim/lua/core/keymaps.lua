-- OPTIMIZE: This method should be refactor
M = {}

M.general = {
  {
    mode = 'n',
    '<C-s>',
    function()
      vim.b.do_format = true
      return '<CMD>w<CR>'
    end,
    noremap = true,
    expr = true,
    desc = 'Format and save file',
  },
  { mode = 'n', '<C-h>', '<C-w>h' },
  { mode = 'n', '<C-j>', '<C-w>j' },
  { mode = 'n', '<C-k>', '<C-w>k' },
  { mode = 'n', '<C-l>', '<C-w>l' },
  { mode = 'n', '<tab>', '<CMD>tabnext<CR>' },
  { mode = 'n', '<s-tab>', '<CMD>tabprev<CR>' },
  { mode = 'n', '/', 'ms/', noremap = true },
  { mode = 'n', '?', 'ms?', noremap = true },
  { mode = 'n', 'Q', '<CMD>q<CR>', noremap = true, desc = 'Quit' },
  {
    mode = 'n',
    '<C-q>',
    function()
      if vim.fn.tabpagenr('$') > 1 then
        return '<CMD>tabclose<CR>'
      else
        return '<CMD>qall<CR>'
      end
    end,
    noremap = true,
    expr = true,
    desc = 'Close tab',
  },
  {
    mode = 'n',
    '<C-t>',
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
    expr = true,
  },
  { mode = '!', '<C-l>', '<Delete>' },
  { mode = 't', '<C-h>', '<C-w>h' },
  { mode = 't', '<C-j>', '<C-w>j' },
  { mode = 't', '<C-k>', '<C-w>k' },
  { mode = 't', '<C-l>', '<C-w>l' },
}

M['nvim-tree'] = {
  { mode = 'n', '<F2>', '<CMD>NvimTreeToggle<CR>', noremap = true },
}

M.cocnvim = {
  { mode = 'n', '<C-n>', '<Plug>(coc-cursors-word)g*', noremap = true },
  { mode = 'n', '<leader><leader>', '<Plug>(coc-cursors-position)', noremap = true },
  {
    mode = 'n',
    '<leader>F',
    function()
      vim.fn.CocAction('format')
    end,
    noremap = true,
    desc = 'Format',
  },
  { mode = 'n', '[g', '<Plug>(coc-diagnostic-prev)', noremap = true, silent = true },
  { mode = 'n', ']g', '<Plug>(coc-diagnostic-next)', noremap = true, silent = true },
  { mode = 'x', '<C-n>', "y/\\V<C-r>=escape(@\", '/\\')<CR><CR>Ngn<Plug>(coc-cursors-range)ngn", noremap = true },
  {
    mode = 'i',
    '<C-y>',
    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    noremap = true,
    silent = true,
    expr = true,
    replace_keycodes = false,
  },
}

M.aerial = {
  { mode = 'n', '<F8>', '<cmd>AerialToggle!<CR>', noremap = true, silent = true },
}

M.lspsaga = {
  { mode = 'n', 'K', '<CMD>Lspsaga hover_doc<CR>' },
  { mode = 'n', 'grd', '<CMD>Lspsaga goto_definition<CR>' },
  { mode = 'n', 'grf', '<CMD>Lspsaga finder<CR>' },
  { mode = 'n', 'grn', function() vim.lsp.buf.rename() end, desc = 'Rename' },
  { mode = 'n', 'gj', '<CMD>Lspsaga diagnostic_jump_next<CR>' },
  { mode = 'n', 'gk', '<CMD>Lspsaga diagnostic_jump_prev<CR>' },
  { mode = 'n', 'grp', '<CMD>Lspsaga peek_definition<CR>' },
  { mode = 'n', 'gri', '<CMD>Lspsaga incoming_calls<CR>' },
  { mode = 'n', 'gro', '<CMD>Lspsaga outgoing_calls<CR>' },
  { mode = 'n', 'gra', '<CMD>Lspsaga code_action<CR>' },
  { mode = 'n', 'grO', '<CMD>Lspsaga outline<CR>' },
  { mode = 'n', '<leader>F', function() vim.lsp.buf.format({ async = true }) end, desc = 'Format' },
}

M.lsp = {
  { mode = 'n', 'K', vim.lsp.buf.hover },
  {
    mode = 'n',
    '<leader>F',
    function()
      vim.lsp.buf.format({ async = true })
    end,
  },
  {
    mode = 'n',
    '<leader>a',
    function()
      vim.lsp.buf.code_action()
    end,
  },
  {
    mode = 'n',
    'gd',
    function()
      vim.lsp.buf.definition({ reuse_win = false })
    end,
  },
  {
    mode = 'n',
    'gD',
    function()
      vim.lsp.buf.declaration()
    end,
  },
  {
    mode = 'n',
    'gI',
    function()
      vim.lsp.buf.implementation()
    end,
  },
  {
    mode = 'n',
    'gr',
    function()
      vim.lsp.buf.references()
    end,
  },
  {
    mode = 'n',
    '<leader>wa',
    function()
      vim.lsp.buf.add_workspace_folder()
    end,
  },
  {
    mode = 'n',
    '<leader>wr',
    function()
      vim.lsp.buf.remove_workspace_folder()
    end,
  },
  {
    mode = 'n',
    '<leader>wl',
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
  },
  {
    mode = 'n',
    '<leader>rn',
    function()
      vim.lsp.buf.rename()
    end,
  },
  {
    mode = 'n',
    'gj',
    function()
      vim.diagnostic.jump({ count = 1 })
    end,
  },
  {
    mode = 'n',
    'gk',
    function()
      vim.diagnostic.jump({ count = -1 })
    end,
  },
}

M.telescope = {
  { mode = 'n', '<leader>fb', '<CMD>Telescope buffers<CR>', noremap = true, desc = 'Find buffers' },
  { mode = 'n', '<leader>fd', '<CMD>Telescope diagnostics<CR>', noremap = true, desc = 'Find diagnostic' },
  { mode = 'n', '<leader>fc', '<CMD>Telescope colorscheme enable_preview=true<CR>', noremap = true, desc = 'Colorscheme' },
  { mode = 'n', '<leader>ff', '<CMD>Telescope find_files<CR>', noremap = true, desc = 'Find files' },
  { mode = 'n', '<leader>fk', '<CMD>Telescope keymaps<CR>', noremap = true, desc = 'Find keymaps' },
}

M.gitsigns = {
  {
    mode = 'n',
    '<leader>gn',
    function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        require('gitsigns').nav_hunk('next')
      end
    end,
    noremap = true,
    desc = 'Go to next hunk',
  },
  {
    mode = 'n',
    '<leader>gp',
    function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        require('gitsigns').nav_hunk('prev')
      end
    end,
    noremap = true,
    desc = 'Go to prev hunk',
  },
  { mode = 'n', '<leader>gd', '<CMD>Gitsigns diffthis HEAD vertical=true<CR>' },
}

M.luasnip = {
  { mode = 'i', '<TAB>', function() require('luasnip').jump(1) end, silent = true },
  { mode = 'i', '<s-TAB>', function() require('luasnip').jump(-1) end, silent = true },
}

M['grug-far'] = {
  {
    mode = 'n',
    '<leader>S',
    function()
      require('grug-far').open()
    end,
    desc = 'Open grug-far',
  },
  {
    mode = 'v',
    '<leader>S',
    function()
      require('grug-far').open({
        startInInsertMode = false,
      })
    end,
    desc = 'Open grug-far',
  },
}

M.debug_mode = {
  { mode = 'n', '<F6>', '<CMD>ToggleDebugMode<CR>', desc = 'Toggle debug mode' },
}

M.dap = {
  { mode = 'n', '<leader>df', '<CMD>ToggleDebugKeymap<CR>', desc = 'Toggle debug keymap' },
  { mode = 'n', '<leader>db', '<CMD>DapToggleBreakpoint<CR>' },
  { mode = 'n', '<leader>dc', '<CMD>DapContinue<CR>' },
  { mode = 'n', '<leader>dt', '<CMD>DapTerminate<CR>' },
  { mode = 'n', '<leader>di', '<CMD>DapStepInto<CR>' },
  { mode = 'n', '<leader>do', '<CMD>DapStepOut<CR>' },
  { mode = 'n', '<leader>dv', '<CMD>DapStepOver<CR>' },
  { mode = 'n', '<leader>ds', '<CMD>DapShowLog<CR>' },
}

M.fastdap = {
  { mode = 'n', 'b', '<CMD>DapToggleBreakpoint<CR>' },
  { mode = 'n', 'c', '<CMD>DapContinue<CR>' },
  { mode = 'n', 't', '<CMD>DapTerminate<CR>' },
  { mode = 'n', 'i', '<CMD>DapStepInto<CR>' },
  { mode = 'n', 'o', '<CMD>DapStepOut<CR>' },
  { mode = 'n', 'v', '<CMD>DapStepOver<CR>' },
  { mode = 'n', 's', '<CMD>DapShowLog<CR>' },
}

M['zen-mode'] = {
  { mode = 'n', 'Z', '<CMD>ZenMode<CR>' },
}

M.python = {
  { mode = 'n', '<F9>', '<CMD>!python %<CR>', noremap = true, ft = 'python' },
}

M.lua = {
  { mode = 'n', '<F9>', '<CMD>!lua %<CR>', noremap = true, silent = true, ft = 'lua' },
}

M.c = {
  { mode = 'n', '<F9>', '<CMD>!gcc %:p -o %:p:r && %:p:r<CR>', noremap = true, silent = true, ft = 'c' },
}

M.cpp = {
  { mode = 'n', '<F9>', '<CMD>!g++ %:p -o %:p:r && %:p:r<CR>', noremap = true, silent = true, ft = 'cpp' },
}

M.sh = {
  { mode = 'n', '<F9>', '<CMD>!%:p<CR>', noremap = true, silent = true, ft = { 'sh' } },
}

return M
