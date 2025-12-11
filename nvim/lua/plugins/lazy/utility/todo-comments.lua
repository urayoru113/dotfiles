return {
  "folke/todo-comments.nvim",
  cond = vim.fn.executable("rg"),
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)
    require("telescope").load_extension("todo-comments")
  end,
}
