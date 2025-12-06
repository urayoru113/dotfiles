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
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return
        end
        vim.lsp.buf.format({ async = true })
      end,
    },
  },
}

M['nvim-tree'] = function()
  local api = require('nvim-tree.api')
  local startup_config = require('core.config.startup')
  return {
    {
      'VimEnter',
      {
        callback = function(e)
          if e.file == '' then
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
end

M['neo-tree'] = function()
  local neo_tree_config = require('plugins.config.neo-tree')
  local startup_config = require('core.config.startup')
  return {
    {
      'VimEnter',
      {
        callback = function(e)
          if e.file == '' and package.loaded[startup_config.provider] then
            vim.cmd(startup_config.providers[startup_config.provider])
          end
          vim.cmd('Neotree show reveal_force_cwd')
        end,
      },
    },
    {
      { 'TabEnter' },
      {
        callback = function()
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
end

M['dap-view'] = {
  {
    'BufEnter',
    {
      callback = function()
        local dapview = require('dap-view')
        local util = require('dap-view.util')
        local state = require('dap-view.state')
        local dap = require('plugins.config.dap')
        if dap.is_debug_mode then
          if not util.is_win_valid(state.winnr) then
            dapview.open()
          end
        end
      end,
    },
  },
}
return M
