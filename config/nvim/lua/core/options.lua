-- == Disable these options to speed up startup ==
vim.g.loaded_python3_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- ===============================================
vim.g.ftplugin_sql_omni_key = "<C-j>"
vim.g.clipboard = "win32yank"

vim.b.do_format = false

-- ===============================================
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.endofline = false
vim.opt.eol = false
vim.opt.expandtab = true
vim.opt.fixendofline = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftround = true
vim.opt.smarttab = true
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.ttyfast = true
vim.opt.wrap = false

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.complete:append("kspell")
vim.opt.completeopt = "menu"
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.laststatus = 3
vim.opt.matchpairs:append("<:>")
vim.opt.mouse = "a"
vim.opt.numberwidth = 2
vim.opt.scroll = 10
vim.opt.scrolloff = 8
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.winborder = "single"
-- vim.opt.winborder = '◯,─,◯,│,◯,─,◯,│' Neovim 1.11 is not supported yet
