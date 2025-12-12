return {
  -- https://github.com/stevearc/conform.nvim
  "stevearc/conform.nvim",
  lazy = true,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf.format = function(format_opts)
      require("conform").format(vim.tbl_extend("force", format_opts or {}, {
        lsp_format = "last", -- use lspconfig first
      }))
    end
  end,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
      nix = { "nixfmt" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      kdl = { "kdlfmt" },

      -- Use the "*" filetype to run formatters on all filetypes.
      ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = {},
    },
    notify_no_formatters = false,
  },
}
