local spec = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  cond = function()
    local found_paths = vim.fs.find(
      ".git",
      {
        upward = true,
        limit = 1,
        type = "directory",
      }
    )
    return #found_paths > 0
  end,
  init = function()
    require("core.utils").load_mappings(require("core.keymaps")["gitsigns"])
  end,
  opts =
  {
    signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false,      -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false,     -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false,  -- Toggle with `:Gitsigns toggle_word_diff`
  },
}

return spec
