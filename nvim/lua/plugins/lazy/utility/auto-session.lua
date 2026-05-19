local filetree = require("core.config.filetree")

local function tree()
  local has_nvim_tree, api = pcall(require, "nvim-tree.api")
  local neo_tree_config = require("plugins.config.neo-tree")
  if has_nvim_tree then
    api.tree.change_root(vim.fn.getcwd())
    api.tree.toggle()
    return
  end

  local has_neo_tree, _ = pcall(require, "neo-tree")
  if has_neo_tree and not neo_tree_config.is_neo_tree_visible() then
    vim.cmd("Neotree show reveal_force_cwd")
    return
  end
end

local function should_create_session()
  for _, marker in ipairs(filetree.project_markers) do
    local match = vim.fs.find(marker, {
      path = vim.fn.getcwd(),
      upward = true,
      stop = vim.fn.expand("$HOME"),
    })

    if #match > 0 then
      return true
    end
  end
end

local should_load_session = function()
  -- Only open session if there is a single directory in the arg list
  if vim.fn.argc() == 0 then return false end
  local has_dir = false

  for i = 0, vim.fn.argc() - 1 do
    local stat = vim.uv.fs_stat(vim.fn.argv(i))

    if stat and stat.type == "directory" then
      if has_dir then return false end
      has_dir = true
    else
      return false
    end
  end

  return has_dir
end

local spec = {
  "rmagatti/auto-session",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = {
    log_level = "error",
    auto_save = true,
    auto_restore = false,
    auto_create = should_create_session,
    post_restore_cmds = {
      tree,
    },
    git_use_branch_name = true,
    session_lens = {
      previewer = "active_buffer",
    },
  },
  version = "v2.*",
  config = function(_, opts)
    require("auto-session").setup(opts)
  end,
}

return spec
