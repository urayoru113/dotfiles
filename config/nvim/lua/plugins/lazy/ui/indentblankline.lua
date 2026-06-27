--vim.g.indent_blankline_char = "￤"

local spec = {
  "lukas-reineke/indent-blankline.nvim",
  --- @module "ibl"
  --- @type ibl.config
  opts = {
    indent = {
      smart_indent_cap = true,
      char = { "╎" },
    },
    scope = {
      highlight = "Type",
      char = "│",
      show_end = true,
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#666666", nocombine = true })
    local ibl = require("ibl")
    ibl.setup(opts)
  end,
}

return spec
