return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".git" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = false,
        path = {
          "lua/?/init.lua",
          "lua/?.lua",
        },
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
        libraryFiles = "Disable",
        workspaceDelay = 100,
        disable = { "missing-fields" },
      },
      completion = {
        enable = true,
        displayContext = 10,
      },
      workspace = {
        checkThirdParty = false,
      },
      format = {
        enable = false,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          quote_style = "double",
          call_arg_parentheses = "keep",
          trailing_table_separator = "smart",
          align_call_args = "false",
          align_function_params = "false",
          align_continuous_assign_statement = "false",
          align_continuous_rect_table_field = "false",
          align_array_table = "false",
        },
      },
      hint = {
        enable = true,
      },
      hover = {
        enable = true,
      },
    },
  },
}
