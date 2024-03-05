local M = {}
if type(unpack) == nil then
  unpack = table.unpack
end

M.load_mappings = function(name)
  vim.schedule(function()
    local mappings = require("core.mappings")
    if mappings[name] == nil then
      error("Keymap '" .. name .. "' not found")
      return
    end
    for mode, sect in pairs(mappings[name]) do
      for keybind, info in pairs(sect) do
        vim.keymap.set(mode, keybind, info[1], info.opt or {})
      end
    end
  end)
end

M.load_autocmds = function(name)
  local autocmds = require("core.autocmds")
  if autocmds[name] == nil then
    error("Autocmd '" .. name("' not found"))
    return
  end
  local autocmd = vim.api.nvim_create_autocmd
  for _, cmd in pairs(autocmds[name]) do
    autocmd(unpack(cmd))
  end
end

M.load_configs = function(dir)
  local path = vim.fn.stdpath("config") .. "/lua/" .. dir
  if vim.fn.isdirectory(path) == 0 then
    error("Configs in '" .. dir .. "' not found in " .. vim.fn.stdpath("config"))
    return
  end
  local configs = {}
  for k, v in pairs(vim.fn.readdir(path)) do
    k = vim.fn.fnamemodify(v, ":r")
    v = require(dir .. "." .. k)
    configs[k] = v
  end
  return configs
end

M.alpha_icon_table = function(icon_name)
  local icon_table = {}
  if type(icon_name) == "string" then
    local icon_dir = vim.fn.stdpath("config") .. "/data/" .. icon_name
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

M.tbl_deepcopy = function(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == "table" then
    copy = {}
    for orig_key, orig_value in pairs(orig) do
      copy[M.tbl_deepcopy(orig_key)] = M.tbl_deepcopy(orig_value)
    end
    setmetatable(copy, M.tbl_deepcopy(getmetatable(orig)))
  else -- number, string, boolean, etc
    copy = orig
  end
  return copy
end

M.tbl_deep_merge = function(keep, orig, target)
  -- Merge two tables.
  -- If key in target is number, target[key] will insert into orig
  if type(keep) ~= "boolean" then
    error('invaild "keep" ' .. type(target))
  end
  local orig_copy = M.tbl_deepcopy(orig)
  local target_copy = M.tbl_deepcopy(target)
  local function _tbl_deep_merge(_keep, _orig, _target)
    for k, v in pairs(_target) do
      if type(k) == "number" then
        table.insert(_orig, v)
      elseif type(v) == "table" and type(_orig[k]) == "table" then
        _tbl_deep_merge(_keep, _orig[k], _target[k])
      else
        if not _keep or not _orig[k] then
          _orig[k] = v
        end
      end
    end
  end
  _tbl_deep_merge(keep, orig_copy, target_copy)
  return orig_copy
end

return M
