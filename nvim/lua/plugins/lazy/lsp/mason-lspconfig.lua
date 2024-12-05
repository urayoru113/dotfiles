local providers = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				completion = {
					enable = false,
					callSnippet = "both",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VINRUNTIME,
					},
				},
				telemetry = {
					enable = false,
				},
				hint = {
					enable = true,
				},
			},
		},
	},
	pyright = {
		settings = {
			python = {
				analysis = {
					autoImportCompletions = true,
					disableOrganizeImports = true,
					diagnosticMode = "workspace",
				},
				pythonPath = (function()
					if vim.fn.executable("pyenv") == 1 then
						return vim.fn.system("echo -n `pyenv which python`")
					else
						return vim.fn.system("echo -n `which python`")
					end
				end)(),
				venvPath = "",
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
	docker_compose_language_service = {
		settings = {},
	},
	dockerls = {
		settings = {},
	},
	ruff_lsp = {
		init_options = {
			settings = {
				lint = {
					ignore = { "S101" },
					args = {
						"--fix",
						"--extend-select=B,S",
						"--extend-per-file-ignores=test*:S101",
					},
				},
			},
		},
	},
	biome = {},
	ts_ls = {},
	html = {},
}

local options = function()
	local handlers = {}
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lspconfig = require("lspconfig")

	for k, v in pairs(providers) do
		v = vim.tbl_deep_extend("error", v, { capabilities = capabilities })
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
