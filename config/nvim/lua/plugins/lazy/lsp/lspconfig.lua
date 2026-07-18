local spec = {
  "neovim/nvim-lspconfig",
  version = "v2.*",
  init = function()
    local autocmds = require("core.autocmds")
    local utils = require("core.utils")
    utils.load_autocmds("LspConfig", autocmds["lspconfig"])

    vim.filetype.add({
      pattern = {
        ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
        ["compose%.ya?ml"] = "yaml.docker-compose",
        [".zshrc"] = "sh",
      },
    })
  end,
}
return spec
