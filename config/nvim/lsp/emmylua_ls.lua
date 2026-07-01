local utils = require("core.utils")
return {
  settings = {
    emmylua_ls = {
      -- Lua = {
      runtime = {
        version = "LuaJIT",
        requirePattern = { "?.lua", "?/init.lua" },
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      completion = {
        enable = true,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME .. "/lua", -- Use lazedev
          -- unpack(vim.fn.glob(vim.fn.stdpath("data") .. "/lazy/*", false, true)), -- Use lazydev
        },
        workspaceRoots = { utils.get_project_path() },
      },
      hint = {
        enable = true,
      },
    },
  },
}
