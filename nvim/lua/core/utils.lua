local M = {}

M.load_mappings = function(name)
  local mappings = require "core.mappings"
  if mappings[name] == nil then
    error("Keymap '" .. name .. "' not found")
    return
  end
  local section_values = mappings[name]
  for mode, maps in pairs(section_values) do
    for _, map in pairs(maps) do
      vim.keymap.set(mode, map.lhs, map.rhs, map.opt or {})
    end
  end
end

M.alpha_icon_table = function(icon_name)
  local icon_table = {}
  if type(icon_name) == "string" then
    local icon_dir = vim.fn.stdpath('config') .. "/data/" .. icon_name
    local icon_fp = io.open(icon_dir, "r")
    if vim.fn.isdirectory(icon_dir) then
      if icon_fp ~= nil then
        for line in icon_fp:lines() do
          table.insert(icon_table, line)
        end
        icon_fp:close()
      else
        error("Could not open file '" .. icon_name .. "'")
      end
    else
      error("Splash file '" .. icon_name .. "' not found")
    end
  else
    error("Type error: " .. type(icon_name))
  end
  return icon_table
end

return M
