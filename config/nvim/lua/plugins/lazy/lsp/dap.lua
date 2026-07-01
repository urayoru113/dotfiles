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
    lazy = true,
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
    --- @type dapview.Config
    opts = {
      follow_tab = true,
      windows = {
        size = 0.2,
        position = "below",
        terminal = {
          hide = true,
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    keys = keymaps["debug_mode"],
    init = function()
      require("plugins.config.dap").setup()
    end,
    opts = function()
      return {
        handlers = {
          function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require("mason-nvim-dap").default_setup(config)
          end,
          python = function(config)
            config.configurations = {
              {
                pythonPath = function()
                  return "./.venv/bin/python"
                end,
                type = "python",
                request = "launch",
                name = "isort: Debug Bug #2124",
                module = "isort",
                args = { "--profile", "black", "--diff", "temp.py" },
                console = "integratedTerminal",
              },
            }
            require("mason-nvim-dap").default_setup(config)
            --local dap = require('dap')
            --dap.defaults.fallback.external_terminal = {
            --  command = "tmux",
            --  args = { "split-window", "-h", "-d", "-p", "35" }
            --}
          end,
        },
      }
    end,
  },
}

return specs
