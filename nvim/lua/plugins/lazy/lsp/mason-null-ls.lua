local options = function()
  return {
    handlers = {},
  }
end

local spec = {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = options,
  init = function()
    require("core.utils").load_mappings("lsp")
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function(_, opts)
    local null_ls = require("null-ls")
    require("mason-null-ls").setup(opts)
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "mysql", "--exclude-rules", "LT02,LT09" },
        }),
        null_ls.builtins.diagnostics.djlint.with({
          filetypes = { "mustache" },
        }),
      },
    })
  end,
}

return spec
