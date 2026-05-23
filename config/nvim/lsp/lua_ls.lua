return {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path == vim.fn.stdpath("config") or string.match(path, "/dotfiles$") then
        table.insert(client.config.settings.Lua.workspace.library, vim.fn.stdpath("data") .. "/lazy")
      end
    end
  end,
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
        globals = { "vim" },
        libraryFiles = "Disable",
        workspaceDelay = 100,
      },
      completion = {
        enable = true,
        displayContext = 10,
      },
      workspace = {
        checkThirdParty = "Disable",
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "4",
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
    },
  },
}
