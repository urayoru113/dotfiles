local M = {}

local utils = require('core.utils')

local manager = require('neo-tree.sources.manager')
local renderer = require('neo-tree.ui.renderer')

M.throttle_neotree_open = utils.throttle(
  function()
    vim.cmd('Neotree show reveal_force_cwd')
  end, 80)

M.is_neo_tree_visible = function()
  return renderer.window_exists(manager.get_state('filesystem'))
end

return M
