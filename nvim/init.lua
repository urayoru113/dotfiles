_G.M = {}

local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if vim.fn.isdirectory(install_path) == 0 then
	print("Cloning lazy ..")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		install_path,
	})
end
vim.opt.rtp:prepend(install_path)

require("core")
require("core.options")
require("plugins")
require("core.highlight")
