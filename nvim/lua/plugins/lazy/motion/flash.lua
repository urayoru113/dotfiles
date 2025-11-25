local spec = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    search = {
      multi_window = false,
      ---@type Flash.Pattern.Mode
      -- Each mode will take ignorecase and smartcase into account.
      -- * exact: exact match
      -- * search: regular search
      -- * fuzzy: fuzzy search
      -- * fun(str): custom function that returns a pattern
      --   For example, to only match at the beginning of a word:
      --   mode = function(str)
      --     return "\\<" .. str
      --   end,
      mode = 'exact',
      exclude = { 'neo-tree' },
    },
    modes = {
      char = {
        jump_labels = true,
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
    --{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    --{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    --{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

return spec
