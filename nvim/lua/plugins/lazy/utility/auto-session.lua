local function tree()
  local has_nvim_tree, api = pcall(require, 'nvim-tree.api')
  if has_nvim_tree then
    api.tree.change_root(vim.fn.getcwd())
    api.tree.toggle()
    return
  end

  local has_neo_tree, _ = pcall(require, 'neo-tree')
  if has_neo_tree then
    vim.cmd('Neotree action=show reveal')
    return
  end
end


local spec = {
  'rmagatti/auto-session',
  opts = {
    log_level = 'error',
    auto_save = true,
    auto_restore = false,
    post_restore_cmds = {
      tree,
    },
    git_use_branch_name = true,
    session_lens = {
      previewer = 'active_buffer',
    },
  },
  config = function(_, opts)
    require('auto-session').setup(opts)
  end,
}

return spec
