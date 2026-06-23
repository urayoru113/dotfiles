local lazydev_config = require("plugins.config.lazydev")

local M = {}

M.default_sources = {
  "codeium",
  "lsp",
  "path",
  "snippets",
  "buffer",
  -- "minuet",
}

M.per_filetype = {
  lua = function()
    local lua = {
      inherit_defaults = true,
      "nvim_lua",
    }
    if lazydev_config.should_load() then
      table.insert(lua, "lazydev")
    end
    return lua
  end,
  codecompanion = {
    inherit_defaults = true,
    "codecompanion",
  },
  opencode_ask = { "lsp", "buffer" },
}

return M
