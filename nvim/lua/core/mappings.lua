M = {}

M.general = {
	n = {
		{
			lhs = "<C-s>",
			rhs = "<cmd>w<CR>",
			opt = { noremap = true },
		},
		{
			lhs = "<C-d>",
			rhs = "yyp",
		},
		{
			lhs = "<C-h>",
			rhs = "<C-w>h",
		},
		{
			lhs = "<C-j>",
			rhs = "<C-w>j",
		},
		{
			lhs = "<C-k>",
			rhs = "<C-w>k",
		},
		{
			lhs = "<C-l>",
			rhs = "<C-w>l",
		},
		{
			lhs = "<tab>",
			rhs = "gt",
		},
		{
			lhs = "<s-tab>",
			rhs = "gT",
		},
		{
			lhs = "/",
			rhs = "ms/",
		},
		{
			lhs = "?",
			rhs = "ms?",
		},
		{
			lhs = "Q",
			rhs = function()
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
		{
			lhs = "<C-c>",
			rhs = "<Esc>",
		},
		{
			lhs = "<C-l>",
			rhs = "<Delete>",
		},
	},

	[""] = {
		{
			lhs = "<C-c>",
			rhs = "<Esc>",
		},
	},

	t = {
		{
			lhs = "<C-h>",
			rhs = "<C-w>h",
		},
		{
			lhs = "<C-j>",
			rhs = "<C-w>j",
		},
		{
			lhs = "<C-k>",
			rhs = "<C-w>k",
		},
		{
			lhs = "<C-l>",
			rhs = "<C-w>l",
		},
	},
}

M["nvim-tree"] = {
	n = {
		{
			lhs = "<F2>",
			rhs = function()
				return "<CMD>silent NvimTreeToggle<CR>"
			end,
			opt = { noremap = true, expr = true },
		},
	},
}

M.cocnvim = {
	n = {
		{
			lhs = "<C-n>",
			rhs = "<Plug>(coc-cursors-word)g*",
			opt = { noremap = true },
		},
		{
			lhs = "<leader><leader>",
			rhs = "<Plug>(coc-cursors-position)",
			opt = { noremap = true },
		},
		{
			lhs = "<leader>f",
			rhs = function()
				vim.fn.CocAction("format")
			end,
			opt = { noremap = true },
		},
		{
			lhs = "[g",
			rhs = "<Plug>(coc-diagnostic-prev)",
			opt = { noremap = true, silent = true },
		},
		{
			lhs = "]g",
			rhs = "<Plug>(coc-diagnostic-next)",
			opt = { noremap = true, silent = true },
		},
	},
	x = {
		{
			lhs = "<C-n>",
			rhs = "y/\\V<C-r>=escape(@\", '/\\')<CR><CR>Ngn<Plug>(coc-cursors-range)ngn",
			opt = { noremap = true },
		},
	},
	i = {
		{
			lhs = "<C-y>",
			rhs = [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
			opt = { noremap = true, silent = true, expr = true, replace_keycodes = false },
		},
	},
}

M.aerial = {
	n = {
		{
			lhs = "<F8>",
			rhs = "<cmd>AerialToggle!<CR>",
			opt = { noremap = true, silent = true },
		},
	},
}

M.lsp = {
	n = {
		{
			lhs = "K",
			rhs = vim.lsp.buf.hover,
		},
		{
			lhs = "<leader>f",
			rhs = function()
				vim.lsp.buf.format({ async = true })
			end,
		},
		{
			lhs = "gd",
			rhs = function()
				vim.lsp.buf.definition()
			end,
		},
		{
			lhs = "gD",
			rhs = function()
				vim.lsp.buf.declaration()
			end,
		},
		{
			lhs = "gI",
			rhs = function()
				vim.lsp.buf.implementation()
			end,
		},
		{
			lhs = "gr",
			rhs = function()
				vim.lsp.buf.references()
			end,
		},
		{
			lhs = "<leader>rn",
			rhs = function()
				vim.lsp.buf.rename()
			end,
		},
		{
			lhs = "[g",
			rhs = function()
				vim.diagnostic.goto_prev()
			end,
		},
		{
			lhs = "]g",
			rhs = function()
				vim.diagnostic.goto_next()
			end,
		},
	},
}

M["nvim-cmp"] = {
	i = {
		{
			lhs = "<C-n>",
			rhs = function()
				local cmp = require("cmp")
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end,
		},
		{
			lhs = "<C-p>",
			rhs = function()
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
		{
			lhs = "<F9>",
			rhs = "<CMD>!python %<CR>",
			opt = { noremap = true },
		},
	},
}

M.c = {
	n = {
		{
			lhs = "<F9>",
			rhs = "<CMD>!gcc %:p -o %:p:r && %:p:r<CR>",
			opt = { noremap = true, silent = true },
		},
	},
}

M.cpp = {
	n = {
		{
			lhs = "<F9>",
			rhs = "<CMD>!g++ %:p -o %:p:r && %:p:r<CR>",
			opt = { noremap = true, silent = true },
		},
	},
}
return M
