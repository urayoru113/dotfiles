local M = {}

local utils = require("core.utils")

local manager = require("neo-tree.sources.manager")
local renderer = require("neo-tree.ui.renderer")

M.throttle_neotree_open = utils.throttle(
  function()
    vim.cmd("Neotree show reveal_force_cwd")
  end, 80)

M.is_neo_tree_visible = function()
  return renderer.window_exists(manager.get_state("filesystem"))
end

M.smart_neotree_reveal = function()
  local file = vim.api.nvim_buf_get_name(0)

  if file == "" then
    return vim.schedule(function() vim.cmd("Neotree focus") end)
  end

  local stat = vim.uv.fs_stat(file)
  local cmd = (stat and stat.type == "file") and "Neotree reveal_force_cwd" or "Neotree focus"

  vim.schedule(function()
    if vim.api.nvim_win_is_valid(0) then
      vim.cmd(cmd)
    end
  end)
end

return M
