return {
  -- https://github.com/Exafunction/windsurf.nvim
  "Exafunction/windsurf.nvim",
  name = "codeium",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
  },
  event = "InsertEnter",
  opts = {
    enable_cmp_source = false,
    workspace_root = {
      use_lsp = true,
    },
  },
}
