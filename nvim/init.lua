_G.M = {}

require("core")
require("core.options")


local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.isdirectory(install_path) == 0 then
  print("Cloning packer ..")
  vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})

  vim.cmd([[ packadd packer.nvim]])
  require("plugins")
  vim.cmd([[ PackerSync ]])
end

