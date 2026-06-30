return {
  -- https://github.com/stevearc/conform.nvim
  "stevearc/conform.nvim",
  lazy = true,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf.format = function(format_opts)
      require("conform").format(vim.tbl_extend("force", format_opts or {}, {
        -- lsp_format = "last", -- use lspconfig first
      }))
    end
  end,
  ---@type conform.setupOpts
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
      nix = { "alejandra" },
      typescript = { "biome" },
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

    -- Customize formatters setting
    formatters = {
      biome = {
        append_args = { "--line-width=120", "--format-with-errors=true" },
      },
      stylua = {
        append_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
          "--column-width",
          "120",
        },
      },
    },
    notify_no_formatters = false,
  },
}
