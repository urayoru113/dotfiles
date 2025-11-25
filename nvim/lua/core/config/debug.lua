local M = {}

M.is_debug_mode = false

M.toggle_debug = function()
  M.is_debug_mode = not M.is_debug_mode
  if M.is_debug_mode then
    M.on()
  else
    M.off()
  end
end

M.on = function()
  vim.notify('Debug method on is not implemented', vim.log.levels.WARN)
end

M.off = function()
  vim.notify('Debug method off is not implemented', vim.log.levels.WARN)
end

M.setup = function(opts)
  if not opts or type(opts) ~= 'table' then
    error('Argument `opts` type should be table')
    return
  end
  M.on = opts.on or M.on
  M.off = opts.off or M.off
end

M.__set_up_cmd = function()
  vim.api.nvim_create_user_command('ToggleDebugMode', M.toggle_debug, {})
end

return M
