local function tree()
  local has_nvim_tree, api = pcall(require, 'nvim-tree.api')
  local neo_tree_config = require('plugins.config.neo-tree')
  if has_nvim_tree then
    api.tree.change_root(vim.fn.getcwd())
    api.tree.toggle()
    return
  end

  local has_neo_tree, _ = pcall(require, 'neo-tree')
  if has_neo_tree and not neo_tree_config.is_neo_tree_visible() then
    vim.cmd('Neotree show reveal_force_cwd')
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
