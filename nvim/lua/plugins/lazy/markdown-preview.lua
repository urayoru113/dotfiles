local spec = {
	"iamcco/markdown-preview.nvim",
  init = function()
    require("core.utils").load_mappings("markdown-preview")
  end,
	build = "cd app && npm install",
	ft = "markdown",
}

return spec
