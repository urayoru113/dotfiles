local utils = require('core.utils')

local options = {
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,
    python = function(config)
      config.configurations = {
        {
          type = 'python',
          request = 'launch',
          name = 'debugpy',
          pythonPath = utils.get_project_python_path(),
          module = "pytest",
          args = { "-s", "--show-capture=stdout", "${file}" },
          console = "integratedTerminal"
          --console = "externalTerminal"
        },
      }
      require('mason-nvim-dap').default_setup(config)
      --local dap = require('dap')
      --dap.defaults.fallback.external_terminal = {
      --  command = "tmux",
      --  args = { "split-window", "-h", "-d", "-p", "35" }
      --}
    end
  },
}

local spec = {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap"
  },
  init = function()
    utils.load_custom_cmd("dap")
  end,
  opts = options,
}

return spec
