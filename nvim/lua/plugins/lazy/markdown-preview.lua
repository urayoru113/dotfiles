local spec = {
	"iamcco/markdown-preview.nvim",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    require("core.utils").load_mappings("markdown-preview")
  end,
	build = "cd app && yarn install",
	ft = "markdown",
}

return spec
