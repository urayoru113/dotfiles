local utils = require("core.utils")

local providers = {
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
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
				pythonPath = utils.get_python_path(),
				venvPath = "",
			},
		},
	},
	docker_compose_language_service = {
		settings = {},
	},
	dockerls = {
		settings = {},
	},
	ruff = {
		on_attach = function(client)
			client.server_capabilities.hoverProvider = false
		end,
		init_options = {
			settings = {
				--configuration = vim.fn.expand("%:p:h") .. "pyproject.toml",
				configurationPreference = "filesystemFirst",
				lineLength = 120,
				lint = {
					extendSelect = {
						"B", -- flake8-bugbear
						"S", -- flake8-bandit
						"E", -- Error
						"W", -- Warning
						"F", -- pyflakes
						"PT", -- flake8-pytest-style
					},
					ignore = { "S101" }, -- https://docs.astral.sh/ruff/rules/assert/
					--extendPerFileIgnores = {"test*:S101"}
				},
			},
		},
	},
	biome = {},
	ts_ls = {},
	taplo = {},
	html = {},
	clangd = {},
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
	opts = options,
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		vim.api.nvim_command("LspStart")
	end,
}

return spec
