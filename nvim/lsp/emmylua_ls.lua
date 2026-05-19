return {
  settings = {
    emmylua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = false,
        requirePattern = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      completion = {
        enable = true,
        callSnippet = true,
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      diagnostics = {
        globals = { "vim" },
      },
      hint = {
        enable = true,
      },
      strict = {
        requirePath = true,
      },
    },
  },
}
