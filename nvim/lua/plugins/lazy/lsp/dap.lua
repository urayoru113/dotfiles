local utils = require("core.utils")
local autocmds = require("core.autocmds")
local dap_config = require("plugins.config.dap")

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
		lazy = true,
		init = function()
			utils.load_autocmds("DapView", autocmds["dap-view"])
		end,
		opts = {
			follow_tab = true,
			windows = {
				height = 0.2,
				position = "below",
			},
		},
	},
	{
		enabled = false,
		"mfussenegger/nvim-dap-python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dap_python = require("dap-python")
			dap_python.setup(utils.get_project_python_path())
			dap_python.test_runner = "pytest"
		end,
	},
}

return specs
