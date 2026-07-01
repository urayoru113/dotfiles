local M = {}

local utils = require("core.utils")
local keymaps = require("core.keymaps")
local filetree = require("core.config.filetree")

M.general = {
  {
    "Filetype",
    {
      pattern = { "python", "c", "cpp", "sh", "lua" },
      callback = function(e)
        utils.load_mappings(keymaps[e.match])
      end,
    },
  },
  {
    "CursorMoved",
    {
      callback = function()
        --if package.loaded["lspsaga"] then
        --  vim.cmd("Lspsaga show_cursor_diagnostics ++unfocus")
        --else
        vim.schedule(vim.diagnostic.open_float)
        --end
      end,
    },
  },
  {
    "ColorScheme",
    {
      callback = function()
        utils.load_highlights("general") -- force my personal highlight
      end,
    },
  },
  {
    "BufWritePre",
    {
      callback = function()
        if not vim.b.do_format then
          return
        end
        vim.lsp.buf.format()
        vim.b.do_format = false
      end,
    },
  },
  {
    { "BufEnter" },
    {
      callback = function()
        if vim.bo.buftype == "" then
          vim.opt_local.modifiable = vim.g.file_editable
        end
      end,
    },
  },
  {
    { "BufLeave" },
    {
      callback = function()
        if vim.bo.buftype == "" then
          vim.opt_local.modifiable = true
        end
      end,
    },
  },
}

M["nvim-tree"] = {
  {
    "VimEnter",
    {
      callback = function(e)
        local startup_config = require("core.config.startup")
        if e.file == "" and filetree.should_open then
          vim.cmd(startup_config.providers[startup_config.provider])
        end
        vim.cmd("NvimTreeOpen")
      end,
    },
  },
  {
    "BufEnter",
    {
      callback = function()
        local api = require("nvim-tree.api")
        if filetree.should_open and not api.tree.is_visible() then
          api.tree.open()
        end
        if not filetree.should_open and api.tree.is_visible() then
          api.tree.close()
        end
      end,
    },
  },
}

M["neo-tree"] = {
  {
    "VimEnter",
    {
      callback = function(e)
        local startup_config = require("core.config.startup")
        if e.file == "" and package.loaded[startup_config.provider] then
          vim.cmd(startup_config.providers[startup_config.provider])
        end
        if filetree.should_open then
          vim.cmd("Neotree show reveal_force_cwd")
        end
      end,
    },
  },
  {
    { "TabEnter" },
    {
      callback = function()
        local neo_tree_config = require("plugins.config.neo-tree")
        vim.schedule(function()
          if filetree.should_open and not neo_tree_config.is_neo_tree_visible() then
            neo_tree_config.smart_neotree_reveal()
          end
        end)
        if not filetree.should_open and neo_tree_config.is_neo_tree_visible() then
          vim.cmd("Neotree close")
        end
      end,
    },
  },
}

M["nvim-lint"] = {
  {
    { "TextChanged", "InsertLeave" },
    {
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    },
  },
  {
    "Filetype",
    {
      pattern = "*",
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    },
  },
}

M["codecompanion"] = {
  {
    "User",
    {
      pattern = "CodeCompanionACPConnected",
      callback = function(args)
        local bufnr = args.data.buf
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { "/resume" })
        local chat = require("codecompanion").buf_get_chat(bufnr)
        if chat then
          chat:submit()
        end
      end,
    },
  },
}

M["lspconfig"] = {
  {
    "Filetype",
    {
      pattern = { "nix" },
      callback = function()
        if vim.lsp.config["nixd"] ~= nil then
          vim.lsp.enable("nixd")
        end
      end,
    },
  },
}

return M
