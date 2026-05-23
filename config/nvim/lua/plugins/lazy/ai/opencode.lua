local spec = {
  enabled = true,
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = {  -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  keys = function()
    return {
      { "<leader>oa", mode = { "n", "x" }, function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Ask opencode…" },
      { "<leader>ox", mode = { "n", "x" }, function() require("opencode").select() end, desc = "Select opencode…" },
      { "<leader>ot", mode = { "n", "t" }, function() require("opencode").toggle() end, desc = "Toggle opencode" },
      { "go", mode = { "n", "x" }, function() return require("opencode").operator("@this ") end, expr = true, desc = "Add range to opencode" },
      { "goo", mode = "n", function() return require("opencode").operator("@this ") .. "_" end, expr = true, desc = "Add line to opencode" },
      { "<S-C-u>", mode = "n", function() require("opencode").command("session.half.page.up") end, desc = "Scroll opencode up" },
      { "<S-C-d>", mode = "n", function() require("opencode").command("session.half.page.down") end, desc = "Scroll opencode down" },
    }
  end,
  config = function()
    local opencode_cmd = "opencode --port"
    local terminal_opts = {
      win = {
        position = "right",
        enter = false,
        on_win = function(win)
          require("opencode.terminal").setup(win.win)
        end,
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      lsp = { enabled = true },
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, terminal_opts)
        end,
        stop = function()
          require("snacks.terminal").get(opencode_cmd, terminal_opts):close()
        end,
        toggle = function()
          require("snacks.terminal").toggle(opencode_cmd, terminal_opts)
        end,
      },
    }

    vim.o.autoread = true -- Required for `opts.events.reload`
  end,
}

return spec
