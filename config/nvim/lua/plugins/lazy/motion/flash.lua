local spec = {
  "folke/flash.nvim",
  event = "BufEnter",
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = false,
      mode = "exact",
      exclude = { "neo-tree" },
    },
    modes = {
      char = {
        enabled = false,
      },
      search = {
        enabled = true,
      },
    },
    jump = {
      nohlsearch = true,
    },
  },
  keys = {
    { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "t", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "T", mode = { "n", "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "T", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

return spec
