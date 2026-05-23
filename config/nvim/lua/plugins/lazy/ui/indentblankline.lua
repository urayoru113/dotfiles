--vim.g.indent_blankline_char = "￤"

local spec = {
	"lukas-reineke/indent-blankline.nvim",
	opts = {
		indent = {
			char = "╎",
		},
	},
	config = function(_, opts)
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#666666", nocombine = true })
		local ibl = require("ibl")
		ibl.setup(opts)
	end,
}

return spec
