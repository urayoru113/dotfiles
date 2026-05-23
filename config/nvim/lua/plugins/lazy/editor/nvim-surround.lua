local prefix = "<M-s>"

return {
  enabled = false,
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  opts = {
    keymaps = {
      insert = prefix .. "i",
      insert_line = prefix .. "I",
      normal = prefix,
      -- normal_cur = '<M-e>',
      normal_line = prefix .. "l",
      -- normal_cur_line = '<M-e>l',
      visual = prefix,
      -- visual_line = '<M-e>',
      delete = prefix .. "d",
      change = prefix .. "c",
      change_line = prefix .. "C",
    },
    surrounds = {
      ["q"] = {
        add = { '"""', '"""' },
        find = function()
          return require("nvim-surround.config").get_selection({ pattern = '"""' })
        end,
        delete = '"""',
      },
      ['"""'] = {
        add = { '"""', '"""' },
        find = function()
          return require("nvim-surround.config").get_selection({ pattern = '"""' })
        end,
        delete = '"""',
      },
      ["C"] = {
        add = function()
          local result = M.get_input("Enter the function name: ")
          if result then
            return { { result .. "(" }, { ")" } }
          end
        end,
        find = function()
          local selection = M.get_selection({
            query = {
              capture = "@call.outer",
              type = "textobjects",
            },
          })

          -- We prioritize TreeSitter-based selections if they exist, otherwise fallback on pattern-based search
          if selection then
            return selection
          end
          return M.get_selection({ pattern = "[^=%s%(%){}]+%b()" })
        end,
        delete = "^(.-%()().-(%))()$",
        change = {
          target = "^.-([%w_]+)()%(.-%)()()$",
          replacement = function()
            local result = M.get_input("Enter the function name: ")
            if result then
              return { { result }, { "" } }
            end
          end,
        },
      },
    },
    aliases = {
      ["q"] = '"""',
      ["s"] = "s",
      ["b"] = "b",
      ["B"] = "B",
      ["r"] = "r",
      ["a"] = "a",
    },
  },
}
