return {
	-- https://github.com/mfussenegger/nvim-lint
	"mfussenegger/nvim-lint",
	init = function()
		local utils = require("core.utils")
		local autocmds = require("core.autocmds")
		utils.load_autocmds("NvimLint", autocmds["nvim-lint"])
	end,
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			nix = { "Nix" },
		}
	end,
}
