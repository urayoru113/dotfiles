local M = {}

M.plugins = {
}

M.mappings = require("core.mappings")

M.diagnostic = {
  signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  },
  config = {
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      source = "always",
      focusable = false,
      max_width = 60,
      border = "rounded",
      scope = "cursor",
    },
  }
}

M.python_path = vim.fn.system("which python")

return M
