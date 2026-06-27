return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Beautiful file icons, highly recommended!
  },
  -- Lazy load on these commands or keymaps to save memory!
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Git Diff: Open panel" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Git Diff: Close panel" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Git History: Branch history" },
    { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "Git History: File history" },
  },
  --- @module "diffview",
  --- @type DiffviewConfig
  opts = {
    enhanced_diff_hl = true, -- Enable enhanced diff highlighting
    use_icons = true, -- Use web devicons
    view = {
      -- Default layout is side-by-side horizontal split
      default = { layout = "diff2_horizontal" },
    },
    file_panel = {
      listing_style = "tree", -- Display file list as a tree structure
      tree_options = {
        flatten_dirs = true, -- Automatically flatten empty directories
      },
    },
  },
}
