local spec = {
  {
    "williamboman/mason.nvim",
    opts = {},
    build = ":MasonUpdate",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = true,
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
}

return spec
