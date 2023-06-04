M = {}

M.general = {
	n = {
		["<C-s>"] = { "<cmd>w<CR>", opt = { noremap = true } },
		["<C-d>"] = { "yyp" },
		["<C-h>"] = { "<C-w>h" },
		["<C-j>"] = { "<C-w>j" },
		["<C-k>"] = { "<C-w>k" },
		["<C-l>"] = { "<C-w>l" },
		["<tab>"] = { "gt" },
		["<s-tab>"] = { "gT" },
		["/"] = { "ms/" },
		["?"] = { "ms?" },
		["Q"] = {
			function()
				if vim.fn.tabpagenr("$") > 1 then
					return "<CMD>tabclose<CR>"
				else
					return "<CMD>qall<CR>"
				end
			end,
			opt = { noremap = true, expr = true },
		},
	},

	["!"] = {
		["<C-c>"] = { "<Esc>" },
		["<C-l>"] = { "<Delete>" },
	},

	[""] = {
		["<C-c>"] = { "<Esc>" },
	},

	t = {
		["<C-h>"] = { "<C-w>h" },
		["<C-j>"] = { "<C-w>j" },
		["<C-k>"] = { "<C-w>k" },
		["<C-l>"] = { "<C-w>l" },
	},
}

M["nvim-tree"] = {
	n = {
		["<F2>"] = {
			function()
				return "<CMD>silent NvimTreeToggle<CR>"
			end,
			opt = { noremap = true, expr = true },
		},
	},
}

M.cocnvim = {
	n = {
		["<C-n>"] = { "<Plug>(coc-cursors-word)g*", opt = { noremap = true } },
		["<leader><leader>"] = { "<Plug>(coc-cursors-position)", opt = { noremap = true } },
		["<leader>f"] = {
			function()
				vim.fn.CocAction("format")
			end,
			opt = { noremap = true },
		},
		["[g"] = { "<Plug>(coc-diagnostic-prev)", opt = { noremap = true, silent = true } },
		["]g"] = { "<Plug>(coc-diagnostic-next)", opt = { noremap = true, silent = true } },
	},
	x = {
		["<C-n>"] = { "y/\\V<C-r>=escape(@\", '/\\')<CR><CR>Ngn<Plug>(coc-cursors-range)ngn", opt = { noremap = true } },
	},
	i = {
		["<C-y>"] = {
			[[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
			opt = { noremap = true, silent = true, expr = true, replace_keycodes = false },
		},
	},
}

M.aerial = {
	n = {
		["<F8>"] = { "<cmd>AerialToggle!<CR>", opt = { noremap = true, silent = true } },
	},
}

M.lsp = {
	n = {
		["K"] = { vim.lsp.buf.hover },
		["<leader>f"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
		},
		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
		},
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
		},
		["gI"] = {
			function()
				vim.lsp.buf.implementation()
			end,
		},
		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
		},
		["<leader>rn"] = {
			function()
				vim.lsp.buf.rename()
			end,
		},
		["[g"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
		},
		["]g"] = {
			function()
				vim.diagnostic.goto_next()
			end,
		},
	},
}

M["nvim-cmp"] = {
	i = {
		["<C-n>"] = {
			function()
				local cmp = require("cmp")
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end,
		},
		["<C-p>"] = {
			function()
				local cmp = require("cmp")
				if cmp.visible() then
					cmp.select_prev_item()
				else
					cmp.complete()
				end
			end,
		},
	},
}

M.toggleterm = {}

M.python = {
	n = {
		["<F9>"] = { "<CMD>!python %<CR>", opt = { noremap = true } },
	},
}

M.c = {
	n = {
		["<F9>"] = { "<CMD>!gcc %:p -o %:p:r && %:p:r<CR>", opt = { noremap = true, silent = true } },
	},
}

M.cpp = {
	n = {
		["<F9>"] = { "<CMD>!g++ %:p -o %:p:r && %:p:r<CR>", opt = { noremap = true, silent = true } },
	},
}
return M
