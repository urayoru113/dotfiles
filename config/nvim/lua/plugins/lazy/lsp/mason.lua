local utils = require("core.utils")
local keymaps = require("core.keymaps")

local spec = {
	{
		"williamboman/mason.nvim",
		opts = {},
		build = ":MasonUpdate",
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		keys = keymaps["debug_mode"],
		opts = function()
			require("plugins.config.dap").setup()
			require("nvim-dap-virtual-text")
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
								type = "python",
								request = "launch",
								name = "debugpy",
								pythonPath = utils.get_project_python_path(),
								module = "pytest",
								args = { "-s", "--show-capture=stdout", "${file}" },
								console = "integratedTerminal",
								--console = "externalTerminal"
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

return spec
