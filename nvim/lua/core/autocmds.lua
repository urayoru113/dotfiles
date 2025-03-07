local M = {}

local utils = require("core.utils")
local has_lspsaga, _ = pcall(require, "lspsaga")

M.general = {
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
  {
    "Filetype",
    {
      pattern = { "c" },
      callback = function()
        utils.load_mappings("c")
      end,
    }
  },
  {
    "Filetype",
    {
      pattern = { "cpp" },
      callback = function()
        utils.load_mappings("cpp")
      end,
    }
  },
  {
    "CursorMoved",
    {
      callback = function()
        --if has_lspsaga then
        --  vim.api.nvim_command("Lspsaga show_cursor_diagnostics ++unfocus")
        --else
        vim.diagnostic.open_float()
        --end
      end,
    }
  },
  {
    "ColorScheme",
    {
      callback = function()
        utils.load_highlights("general")
      end
    }
  }
}

M["nvim-tree"] = {
  {
    "VimEnter",
    {
      callback = function(data)
        if data.file == "" then
          return
        end
        vim.api.nvim_command("NvimTreeOpen")
      end,
    },
  },
  {
    "BufEnter",
    {
      callback = function()
        if vim.fn.winnr("$") == 1 and vim.o.filetype == "NvimTree" then
          vim.api.nvim_command("q")
        end
      end,
    },
  },
}

return M
