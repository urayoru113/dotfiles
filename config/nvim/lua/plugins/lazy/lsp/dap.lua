local dap_config = require("plugins.config.dap")
local utils = require("core.utils")

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
    enabled = true,
    ft = "python",
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap_python = require("dap-python")
      dap_python.setup("uv")
      dap_python.test_runner = "pytest"
      local dap = require("dap")
      table.insert(
        dap.configurations.python,
        --- @type dap.Configuration
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
        }
      )
    end,
  },
}

return specs
