local options = {
	prompt_prefix = " ",
	path_display = { "smart" },
}

local spec = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.0",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = options,
}

return spec
