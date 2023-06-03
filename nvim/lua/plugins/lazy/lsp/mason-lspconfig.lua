local providers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	pyright = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { "W391" },
						maxLineLength = 100,
					},
				},
			},
		},
	},
}

local options = function()
	local handlers = {}
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lspconfig = require("lspconfig")

	for k, v in pairs(providers) do
		v.capabilities = capabilities
		handlers[k] = function()
			lspconfig[k].setup(v)
		end
	end
	return {
		handlers = handlers,
	}
end

local spec = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	init = function()
		require("core.utils").load_mappings("lsp")
	end,
	opts = options,
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		vim.api.nvim_command("LspStart")
	end,
}

return spec
