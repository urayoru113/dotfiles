-- OPTIMIZE: This method should be refactor

local M = {}

local utils = require('core.utils')
local keymaps = require('core.keymaps')
local filetree = require('core.config.filetree')

M.general = {
  {
    'Filetype',
    {
      pattern = { 'python', 'c', 'cpp', 'sh', 'lua' },
      callback = function(e)
        utils.load_mappings(keymaps[e.match])
      end,
    },
  },
  {
    'CursorMoved',
    {
      callback = function()
        --if package.loaded["lspsaga"] then
        --  vim.cmd("Lspsaga show_cursor_diagnostics ++unfocus")
        --else
        vim.schedule(vim.diagnostic.open_float)
        --end
      end,
    },
  },
  {
    'ColorScheme',
    {
      callback = function()
        utils.load_highlights('general') -- force my personal highlight
      end,
    },
  },
  {
    'BufWritePre',
    {
      callback = function()
        if not vim.b.do_format or #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
          return
        end
        vim.lsp.buf.format()
        vim.b.do_format = false
      end,
    },
  },
}

M['nvim-tree'] = {
  {
    'VimEnter',
    {
      callback = function(e)
        local startup_config = require('core.config.startup')
        if e.file == '' and filetree.should_open then
          vim.cmd(startup_config.providers[startup_config.provider])
        end
        vim.cmd('NvimTreeOpen')
      end,
    },
  },
  {
    'BufEnter',
    {
      callback = function()
        local api = require('nvim-tree.api')
        if filetree.should_open and not api.tree.is_visible() then
          api.tree.open()
        end
        if not filetree.should_open and api.tree.is_visible() then
          api.tree.close()
        end
      end,
    },
  },
}

M['neo-tree'] = {
  {
    'VimEnter',
    {
      callback = function(e)
        local startup_config = require('core.config.startup')
        if e.file == '' and package.loaded[startup_config.provider] then
          vim.cmd(startup_config.providers[startup_config.provider])
        end
        if filetree.should_open then
          vim.cmd('Neotree show reveal_force_cwd')
        end
      end,
    },
  },
  {
    { 'TabEnter' },
    {
      callback = function()
        local neo_tree_config = require('plugins.config.neo-tree')
        vim.schedule(function()
          if filetree.should_open and not neo_tree_config.is_neo_tree_visible() then
            vim.cmd('Neotree show reveal_force_cwd')
          end
        end)
        if not filetree.should_open and neo_tree_config.is_neo_tree_visible() then
          vim.cmd('Neotree close')
        end
      end,
    },
  },
}

M['dap-view'] = {
  {
    'BufEnter',
    {
      callback = function()
        local dap = require('plugins.config.dap')
        if dap.is_debug_mode then
          local dapview = require('dap-view')
          local util = require('dap-view.util')
          local state = require('dap-view.state')
          if not util.is_win_valid(state.winnr) then
            dapview.open()
          end
        end
      end,
    },
  },
}

return M
