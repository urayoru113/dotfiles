local spec = {
  enabled = false,
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
  -- keys = function()
  --   return {
  --     { "<leader>oa", mode = { "n", "x" }, function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Ask opencode…" },
  --     { "<leader>ox", mode = { "n", "x" }, function() require("opencode").select() end, desc = "Select opencode…" },
  --     { "<leader>ot", mode = { "n", "t" }, function() require("opencode").toggle() end, desc = "Toggle opencode" },
  --     { "go", mode = { "n", "x" }, function() return require("opencode").operator("@this ") end, expr = true, desc = "Add range to opencode" },
  --     { "goo", mode = "n", function() return require("opencode").operator("@this ") .. "_" end, expr = true, desc = "Add line to opencode" },
  --     { "<S-C-u>", mode = "n", function() require("opencode").command("session.half.page.up") end, desc = "Scroll opencode up" },
  --     { "<S-C-d>", mode = "n", function() require("opencode").command("session.half.page.down") end, desc = "Scroll opencode down" },
  --   }
  -- end,
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type for details
    }

    vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end,
      { desc = "Ask OpenCode…" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select OpenCode…" })

    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
      { desc = "Append range to OpenCode", expr = true })
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
      { desc = "Append line to OpenCode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
      { desc = "Scroll OpenCode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
      { desc = "Scroll OpenCode down" })
  end,

}

return spec
