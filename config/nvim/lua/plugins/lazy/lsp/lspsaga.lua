local utils = require("core.utils")
local spec = {
	"nvimdev/lspsaga.nvim",
	opts = {
		lightbulb = {
			enable = false,
		},
		symbol_in_winbar = {
			enable = false,
			show_file = false,
		},
		rename = {
			auto_save = true,
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	event = "LspAttach",
	init = function()
		local keymaps = require("core.keymaps")
		utils.load_mappings(keymaps["lspsaga"])
	end,
}

return spec
