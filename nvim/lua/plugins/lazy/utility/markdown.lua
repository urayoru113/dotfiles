return {
  -- https://github.com/OXY2DEV/markview.nvim
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "latex", "html", "yaml", "codecompanion" },
  init = function()
    local utils = require("core.utils")
    local keymaps = require("core.keymaps")
    utils.load_mappings(keymaps["markview"])
  end,

  -- Completion for `blink.cmp`
  -- dependencies = { "saghen/blink.cmp" },
  opts = {},
}
