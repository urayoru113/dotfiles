local dap_config = require("plugins.config.dap")
local keymaps = require("core.keymaps")

local specs = {
  {
    enabled = dap_config.viewer == "dap-ui",
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      force_buffers = true,
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    keys = "<F6>",
    opts = {
      only_first_definition = false,
    },
  },
  {
    "igorlfs/nvim-dap-view",
    enabled = dap_config.viewer == "dap-view",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    version = "1.*",
    lazy = true,
    --- @module "dap-view"
    --- @type dapview.Config
    opts = {
      follow_tab = true,
      windows = {
        size = 0.3,
        position = "right",
        terminal = {
          hide = true,
        },
      },
    },
  },
  {
    -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    keys = keymaps.debug_mode,
    init = function()
      local debug_config = require("core.config.debug")
      vim.api.nvim_create_user_command("ToggleDebugMode", debug_config.toggle_debug, {})
    end,
    opts = function()
      return {
        handlers = {
          function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      }
    end,
    config = function(_, opts)
      require("plugins.config.dap").setup()
      require("mason-nvim-dap").setup(opts)
    end,
  },
}

return specs
