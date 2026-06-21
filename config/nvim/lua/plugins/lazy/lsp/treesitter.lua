local spec = {
  {
    enabled = false,
    "nvim-treesitter/nvim-treesitter",
    version = "v0.10.0",
    opts = {
      ensure_installed = {
        "vimdoc",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = false,
      },
      endwise = {
        enable = true, -- for neovim < 0.9
      },
    },
    build = ":TSUpdate",
    lazy = false,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    opts = {
      ensure_installed = {
        "vimdoc",
      },
    },
  },
}

return spec
