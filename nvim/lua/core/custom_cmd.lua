local M = {}

local utils = require('core.utils')

local has_dapui, dapui = pcall(require, "dapui")
local has_nvim_tree, api = pcall(require, "nvim-tree.api")
local dap = require('dap')

M.dap = function()
  local is_debug_mode = false

  local dapui_open = function()
    if has_dapui then
      if has_nvim_tree then
        api.tree.close()
      end
      dapui.open({ reset = true })
    end
  end

  local dapui_close = function()
    if has_dapui then
      if has_nvim_tree then
        api.tree.open()
      end
      dapui.close()
    end
    dap.clear_breakpoints()
    dap.terminate()
  end

  vim.api.nvim_create_user_command('ToggleDebugMode', function()
    if is_debug_mode then
      is_debug_mode = false
      utils.delete_mappings("dap")
      dapui_close()
    else
      is_debug_mode = true
      utils.load_mappings("dap")
      dapui_open()
    end
  end, {})
end

return M
