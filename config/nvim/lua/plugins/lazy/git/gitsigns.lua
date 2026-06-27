local spec = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  cond = function()
    local found_paths = vim.fs.find(".git", {
      upward = true,
      limit = 1,
      type = "directory",
    })
    return #found_paths > 0
  end,
  init = function()
    require("core.utils").load_mappings(require("core.keymaps")["gitsigns"])
  end,
  --- @module "gitsigns"
  --- @type Gitsigns.Config
  opts = {
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  },
}

return spec
