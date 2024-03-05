local spec = {
	"stevearc/aerial.nvim",
	opts = {
    manage_folds = true,
  },
	-- Optional dependencies
	init = function()
		require("core.utils").load_mappings("aerial")
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}

return spec
