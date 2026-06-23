local M = {}

M.should_load = function()
  return vim.fn.getcwd():find(vim.fn.expand("~/.dotfiles"), 1, true) == 1
end

return M
