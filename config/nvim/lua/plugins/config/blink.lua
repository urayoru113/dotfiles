local M = {}

M.default_sources = {
  "codeium",
  "lsp",
  "path",
  "snippets",
  "buffer",
}

M.per_filetype = {
  lua = {
    inherit_defaults = true,
    "nvim_lua",
  },
  codecompanion = {
    inherit_defaults = true,
    "codecompanion",
  },
  opencode_ask = { "lsp", "buffer" },
}

return M
