local options = function()
	return {
		automatic_setup = true,
		handlers = {},
	}
end

local spec = {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = options,
	init = function()
		require("core.utils").load_mappings("lsp")
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"williamboman/mason.nvim",
		"jose-elias-alvarez/null-ls.nvim",
	},
	config = function(_, opts)
		local null_ls = require("null-ls")
		require("mason-null-ls").setup(opts)
		null_ls.setup({
			sources = {},
		})
	end,
}

return spec
