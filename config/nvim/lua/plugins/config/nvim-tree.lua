local M = {}

local filetree = require('core.config.filetree')

M.setup = function()
  local api = require('nvim-tree.api')
  local Event = api.events.Event

  api.events.subscribe(Event.TreePreOpen, function()
    filetree.should_open = true
  end)
  api.events.subscribe(Event.TreeClose, function()
    filetree.should_open = false
  end)
end

return M
