local M = {}

--- @type boolean
M.is_debug_keymap = false

--- @type 'dap-view' | 'dap-ui'
M.viewer = 'dap-view'

M.setup = function()
  local debug = require('core.config.debug')
  local dap = require('dap')
  local keymaps = require('core.keymaps')
  local utils = require('core.utils')
  local has_dapview, dapview = pcall(require, M.viewer)
  local debug_on = function()
    if has_dapview then
      dapview.open()
    end
    utils.load_mappings(keymaps.dap)
  end
  local debug_off = function()
    if has_dapview then
      dapview.close()
    end
    dap.clear_breakpoints()
    dap.terminate()
    utils.remove_mappings(keymaps.dap)
    utils.remove_mappings(keymaps.fastdap, true)
  end

  utils.load_mappings(keymaps.debug_mode)

  debug.setup(
    {
      on = function()
        vim.notify('Debug mode on')
        debug_on()
      end,
      off = function()
        vim.notify('Debug mode off')
        debug_off()
      end,
    }
  )

  vim.api.nvim_create_user_command('ToggleDebugKeymap', function()
    if debug.is_debug_mode then
      if M.is_debug_keymap then
        utils.remove_mappings(keymaps.fastdap)
      else
        utils.load_mappings(keymaps.fastdap)
      end
      M.is_debug_keymap = not M.is_debug_keymap
    end
  end, {})
end

return M
