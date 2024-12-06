M.lazy = function()
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

	local plugins = {
		{ import = "plugins.lazy" },
		{ import = "plugins.lazy.lsp" },
		{ import = "plugins.lazy.colorschemes" },
	}

	local options = {
		install = {
			colorscheme = { "moonlight", "tokyonight", "slate" },
		},
		change_detection = {
			notify = false,
			enabled = true,
		},
	}

	require("lazy").setup(plugins, options)

	--require("plugins.lsp").setup()

	vim.api.nvim_command("colorscheme onedark")
end

return M
