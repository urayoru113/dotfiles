local M = {}

M.config = {
  virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.ERROR] = '',
    }
  },
  float = {
    source = 'always',
    focusable = false,
    max_width = 120,
    border = 'rounded',
    scope = 'cursor',
  },
}

return M
