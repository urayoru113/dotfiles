local keymaps = require("core.keymaps")

local options = {
  prompt_prefix = " ",
  path_display = { "smart" },
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      n = {
        ["Q"] = "close",
      },
    },
  },
}

local spec = {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
  },
  opts = options,
  keys = keymaps["telescope"],
  cmd = "Telescope",
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    if vim.fn.executable("rg") == 1 then
      telescope.load_extension("live_grep_args")
    end
  end,
}

return spec
