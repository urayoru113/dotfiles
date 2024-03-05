local M = {}

local is_startup = true

local utils = require("core.utils")

M.general = {
  { "VimEnter", {
    callback = function() end,
    }
  },
  {
    "Filetype",
    {
      pattern = { "python" },
      callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        utils.load_mappings("python")
      end,
    },
  },
  {
    "Filetype",
    {
      pattern = { "javascript" },
      callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
      end,
    },
  },
  { "Filetype", {
    pattern = { "c" },
    callback = function()
      utils.load_mappings("c")
    end,
  } },
  { "Filetype", {
    pattern = { "cpp" },
    callback = function()
      utils.load_mappings("cpp")
    end,
  } },
}

M["nvim-tree"] = {
  {
    "VimEnter",
    {
      callback = function(data)
        if is_startup and data.file == "" then
          is_startup = false
          return
        end
        is_startup = false
        vim.api.nvim_command("NvimTreeOpen")
        vim.api.nvim_command("wincmd p")
      end,
    },
  },
  {
    "BufEnter",
    {
      callback = function()
        if vim.fn.winnr("$") == 1 and vim.o.filetype == "NvimTree" and not is_startup then
          vim.api.nvim_command("q")
        end
      end,
    },
  },
}

return M