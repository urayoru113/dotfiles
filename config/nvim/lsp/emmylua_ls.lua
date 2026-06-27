return {
  settings = {
    emmylua_ls = {
      -- Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      completion = {
        enable = true,
        callSnippet = true,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME, -- Use lazedev
          -- unpack(vim.fn.glob(vim.fn.stdpath("data") .. "/lazy/*", false, true)), -- Use lazydev
        },
        workspaceRoots = { vim.fn.getcwd() },
      },
      hint = {
        enable = true,
      },
    },
  },
}
