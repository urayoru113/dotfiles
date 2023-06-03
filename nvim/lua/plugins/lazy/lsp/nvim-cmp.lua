-- copy from https://github.com/onsails/lspkind.nvim/blob/master/lua/lspkind/init.lua
local kind_presets = {
	default = {
		-- if you change or add symbol here
		-- replace corresponding line in readme
		Text = "󰉿",
		Method = "󰆧",
		Function = "󰊕",
		Constructor = "",
		Field = "󰜢",
		Variable = "󰀫",
		Class = "󰠱",
		Interface = "",
		Module = "",
		Property = "󰜢",
		Unit = "󰑭",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "󰈇",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰏿",
		Struct = "󰙅",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "",
	},
	codicons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
}
-- end copy

local kind_icons = {
	TabNine = "",
}

local options = function()
	local cmp = require("cmp")
	local item_kind = require("cmp.types").lsp.CompletionItemKind
	local kind_menus = {
		nvim_lsp = "[LSP]",
		luasnip = "[Snippet]",
		buffer = "[Buf]",
		path = "[Path]",
		cmp_tabnine = "[TN]",
		cmdline = "[CMD]",
	}
	return {
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = {
			{
				name = "nvim_lsp",
				entry_filter = function(entry, context)
					local kind = entry:get_kind()

					local line = context.cursor_line
					local col = context.cursor.col
					local char_before_cursor = string.sub(line, col - 1, col - 1)

					if char_before_cursor == "." then
						if
							kind ~= item_kind.Field
								and kind ~= item_kind.Method
								and kind ~= item_kind.Variable
								and kind ~= item_kind.Class
								and kind ~= item_kind.Function
							or entry:get_vim_item(0).abbr:sub(1, 1) == "_"
						then
							return false
						end
					elseif string.match(line, "^%s*%w*$") then
						--if kind ~= item_kind.Function and kind ~= item_kind.Variable then
						--	return false
						--end
					end
					return true
				end,
			},
			{ name = "cmp_tabnine" },
			{ name = "buffer" },
			{ name = "path" },
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = (kind_presets.default[vim_item.kind] or kind_icons[vim_item.kind] or "")
					.. " "
					.. vim_item.kind
					.. ":"
				vim_item.menu = kind_menus[entry.source.name] or entry.source.name
				if entry.source.name == "cmp_tabnine" then
					local detail = (entry.completion_item.labelDetails or {}).detail
					if detail and detail:find(".*%%.*") then
						vim_item.menu = vim_item.menu .. " " .. detail
					end
				end
				return vim_item
			end,
		},
		window = {
			documentation = {
				border = "double",
			},
			completion = {
				border = { "◯", "─", "◯", "│", "◯", "─", "◯", "│" },
			},
		},
		sorting = {
			comparators = {
				require("cmp_tabnine.compare"),
				cmp.config.compare.recently_used,
			},
		},
	}
end

local ft_options = {
	lua = {
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lua" },
		},
	},
}

local spec = {
	"hrsh7th/nvim-cmp",

	dependencies = {
		"neovim/nvim-lspconfig",

		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-cmdline",

		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",

		{
			"tzachar/cmp-tabnine",
			build = "./install.sh",
		},
	},
	init = function()
		require("core.utils").load_mappings("nvim-cmp")
	end,
	opts = options,
	config = function(_, opts)
		local cmp = require("cmp")
		local utils = require("core.utils")

		cmp.setup(opts)

		for ft, ft_opts in pairs(ft_options) do
			cmp.setup.filetype(ft, utils.tbl_deep_merge(true, ft_opts, opts))
		end

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		local tabnine = require("cmp_tabnine.config")
		tabnine:setup({
			max_num_results = 3,
			show_prediction_strength = true,
		})
	end,
}

return spec
