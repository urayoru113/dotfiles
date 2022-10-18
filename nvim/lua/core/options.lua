vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.endofline = false
vim.opt.eol = false
vim.opt.fixendofline = false
vim.opt.title = false
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftround = true
vim.opt.smarttab = true
vim.opt.ttyfast = true
vim.opt.title = true
vim.opt.termguicolors = true

vim.opt.backspace = {'indent', 'eol', 'start'}
--vim.opt.colorcolumn = {80}
vim.opt.complete:append('kspell')
vim.opt.completeopt = "menu"
--vim.opt.completeopt = 'noselect,menu'
vim.opt.encoding = 'utf-8'
vim.opt.fileformats = {'unix', 'dos', 'mac'}
vim.opt.laststatus = 2
vim.opt.matchpairs:append('<:>')
vim.opt.mouse = 'a'
vim.opt.numberwidth = 2
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
