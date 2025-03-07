local M = {}

M.signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

M.config = {
  virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    source = "always",
    focusable = false,
    max_width = 120,
    border = "rounded",
    scope = "cursor",
  },
}

return M
