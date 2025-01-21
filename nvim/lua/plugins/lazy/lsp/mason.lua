local spec = {
  "williamboman/mason.nvim",
	init = function()
		require("core.utils").load_mappings("lsp")
	end,
  opts = {},
  build = ":MasonUpdate",
  config = true,
}

return spec
