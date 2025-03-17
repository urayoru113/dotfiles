local utils = require("core.utils")

local options = function()
  local null_ls = require("null-ls")
  return {
    handlers = {
      function() end,
      mypy = function()
        null_ls.register(null_ls.builtins.diagnostics.mypy.with({
          command = (function()
            local local_mypy_path = utils.get_project_venv_path("python") .. "/bin/mypy"
            if vim.fn.executable(local_mypy_path) == 1 then
              return local_mypy_path
            else
              return "mypy"
            end
          end)(),
          extra_args = { "--ignore-missing-imports" },
        }))
      end,
    },
  }
end

local spec = {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = options,
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
