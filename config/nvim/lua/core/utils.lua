local M = {}

if type(unpack) == nil then
  unpack = table.unpack
end

M.load_mappings = function(definition)
  local mappings = type(definition) == 'function' and definition() or definition

  if type(mappings) ~= 'table' then
    error('Mappings definition must result in a table.')
    return
  end

  local has_snacks, snacks = pcall(require, 'snacks')

  for _, keymap_entry in ipairs(mappings) do
    if type(keymap_entry) ~= 'table' then
      goto next_keymap_entry
    end

    local mode = keymap_entry.mode
    local lhs = keymap_entry[1]
    local rhs = keymap_entry[2]
    local opts = {}

    for k, v in pairs(keymap_entry) do
      if type(k) == 'string' and k ~= 'mode' then
        opts[k] = v
      end
    end

    if not mode or not lhs or not rhs then
      goto next_keymap_entry
    end

    if has_snacks then
      snacks.keymap.set(mode, lhs, rhs, opts)
    else
      if type(opts) == 'table' then
        opts.ft = nil -- OPTIM:
        opts.lsp = nil
      end
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    ::next_keymap_entry::
  end
end

M.remove_mappings = function(definition, ignore_nomap)
  if ignore_nomap == nil then
    ignore_nomap = false
  end

  local mappings = type(definition) == 'function' and definition() or definition

  if type(mappings) ~= 'table' then
    error('Mappings definition must result in a table.')
    return
  end

  local delete_keymap = vim.keymap.del

  for _, keymap_entry in ipairs(mappings) do
    if type(keymap_entry) ~= 'table' then
      goto next_keymap_entry_remove
    end

    local mode = keymap_entry.mode
    local lhs = keymap_entry[1]

    if not mode or not lhs then
      goto next_keymap_entry_remove
    end

    if ignore_nomap then
      pcall(delete_keymap, mode, lhs)
    else
      delete_keymap(mode, lhs)
    end
    ::next_keymap_entry_remove::
  end
end

M.load_autocmds = function(name, definition)
  local autocmds_table = type(definition) == 'function' and definition() or definition

  if type(autocmds_table) ~= 'table' then
    error("Autocmds definition for '" .. name .. "' must result in a table.")
    return
  end

  local group_id = vim.api.nvim_create_augroup('Autocmd' .. name, { clear = true })
  local create_autocmd = vim.api.nvim_create_autocmd

  for _, cmd in pairs(autocmds_table) do
    if type(cmd) == 'table' and #cmd == 2 and type(cmd[2]) == 'table' then
      cmd[2].group = group_id
      create_autocmd(unpack(cmd))
    else
      error("Invalid autocmd structure in '" .. name .. "'")
    end
  end
end

M.load_highlights = function(name)
  local highlights = require('core.highlights')
  if highlights[name] == nil then
    error("highlight '" .. name .. "' not found")
    return
  end
  local set_hl = vim.api.nvim_set_hl
  for _, hl in pairs(highlights[name]) do
    set_hl(unpack(hl))
  end
end

M.alpha_icon_table = function(icon_name)
  local icon_table = {}
  if type(icon_name) == 'string' then
    local icon_dir = vim.fn.stdpath('config') .. '/data/' .. icon_name
    local icon_fp = io.open(icon_dir, 'r')
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
    error('Type error: ' .. type(icon_name))
  end
  return icon_table
end

M.tbl_deepcopy = function(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
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

-- Merge two tables.
-- If key in target is number, target[key] will insert into orig
M.tbl_deep_merge = function(keep, orig, target)
  if type(keep) ~= 'boolean' then
    error('invaild type "keep" ' .. type(target))
  end
  local orig_copy = M.tbl_deepcopy(orig)
  local target_copy = M.tbl_deepcopy(target)
  local function _tbl_deep_merge(_keep, _orig, _target)
    for k, v in pairs(_target) do
      if type(k) == 'number' then
        table.insert(_orig, v)
      elseif type(v) == 'table' and type(_orig[k]) == 'table' then
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

-- try to get project python path
M.get_project_python_path = function()
  if vim.fn.getenv('VIRTUAL_ENV') ~= vim.NIL then
    return vim.fn.getenv('VIRTUAL_ENV') .. '/bin/python'
  elseif vim.fn.filereadable('poetry.lock') == 1 and vim.fn.executable('poetry') == 1 then
    return vim.trim(vim.fn.system('poetry env info -e'))
  elseif vim.fn.executable('pyenv') == 1 and vim.fn.filereadable('.python-version') == 1 then
    return vim.trim(vim.fn.system('pyenv which python'))
  else
    return vim.fn.exepath('python')
  end
end

M.get_project_venv_path = function(type)
  -- try to get project venv path
  if type == 'python' then
    if vim.fn.getenv('VIRTUAL_ENV') ~= vim.NIL then
      return vim.fn.getenv('VIRTUAL_ENV')
    elseif vim.fn.filereadable('poetry.lock') == 1 and vim.fn.executable('poetry') == 1 then
      return vim.trim(vim.fn.system('poetry env info -p'))
    elseif vim.fn.executable('pyenv') == 1 and vim.fn.filereadable('.python-version') == 1 then
      return vim.trim(vim.fn.system('pyenv prefix'))
    else
      return ''
    end
  else
    return ''
  end
end

--- Throttles a function call, executing only at the start (leading edge) of the time window.
--- This prevents excessive calls when an event fires rapidly.
--- @param fn fun(...) The target function to be throttled.
--- @param ms number The throttling interval time (in milliseconds).
--- @return fun(...) The throttled function wrapper.
M.throttle = function(fn, ms)
  local last_executed_time = -ms
  local wrapped_fn = vim.schedule_wrap(fn)
  return function(...)
    local now = vim.loop.now()
    local elapsed = now - last_executed_time
    if elapsed >= ms then
      last_executed_time = now
      wrapped_fn(...)
    end
  end
end

return M
