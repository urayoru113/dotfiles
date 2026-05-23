return {
  "SmiteshP/nvim-navbuddy",
  keys = function()
    return {
      { mode = "n", "<leader>nb", "<CMD>Navbuddy<CR>", desc = "Open Navbuddy" },
    }
  end,
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",

  },
  opts = { lsp = { auto_attach = true } },
}
