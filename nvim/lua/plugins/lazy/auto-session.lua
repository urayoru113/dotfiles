local function restore_nvim_tree()
  local ok, api = pcall(require, "nvim-tree.api")
  if not ok then
    return
  end
  api.tree.change_root(vim.fn.getcwd())
  api.tree.toggle()
end

local options = {
  log_level = "error",
  auto_save = true,
  auto_restore = false,
  post_restore_cmds = {
    restore_nvim_tree,
  }
}

local spec = {
  'rmagatti/auto-session',
  dependencies = 'nvim-telescope/telescope.nvim',
  opts = options,
  config = function(_, opts)
    require("auto-session").setup(opts)
    require("telescope").load_extension("session-lens")
  end
}

return spec
