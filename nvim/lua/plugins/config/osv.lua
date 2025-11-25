local M = {}

M.setup = function()
  local osv = require('osv')
  vim.api.nvim_create_user_command(
    'OsvServerStart',
    function()
      osv.launch({ port = 8086 })
    end,
    { nargs = 0, desc = 'Start osv server' }
  )
  vim.api.nvim_create_user_command(
    'OsvServerStop',
    function()
      osv.stop()
    end,
    { nargs = 0, desc = 'Stop osv server' }
  )
end

return M
