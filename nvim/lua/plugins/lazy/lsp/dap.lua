local utils = require('core.utils')
local autocmds = require('core.autocmds')
local dap_config = require('plugins.config.dap')

local specs = {
  {
    enabled = dap_config.viewer == 'dap-ui',
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    opts = {
      force_buffers = true,
    },
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    opts = {
      only_first_definition = false,
    },
  },
  {
    'igorlfs/nvim-dap-view',
    enabled = dap_config.viewer == 'dap-view',
    init = function()
      utils.load_autocmds('DapView', autocmds['dap-view'])
    end,
    opts = {
      follow_tab = true,
      windows = {
        height = 0.2,
        position = 'below',
      },
    },
  },
  {
    enabled = false,
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap_python = require('dap-python')
      dap_python.setup(utils.get_project_python_path())
      dap_python.test_runner = 'pytest'
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    init = function()
      require('plugins.config.dap').setup('dap-view')
    end,
    opts = {
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
              module = 'pytest',
              args = { '-s', '--show-capture=stdout', '${file}' },
              console = 'integratedTerminal',
              --console = "externalTerminal"
            },
          }
          require('mason-nvim-dap').default_setup(config)
          --local dap = require('dap')
          --dap.defaults.fallback.external_terminal = {
          --  command = "tmux",
          --  args = { "split-window", "-h", "-d", "-p", "35" }
          --}
        end,
      },
    },
  },
}

return specs
