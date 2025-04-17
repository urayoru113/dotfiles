local utils = require("core.utils")
local lsp = require("core.config.lsp")

local options = function()
  local handlers = {}
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = utils.tbl_deep_merge(true, require("cmp_nvim_lsp").default_capabilities(), capabilities)

  for k, v in pairs(lsp.providers) do
    v = vim.tbl_deep_extend("error", v, { capabilities = utils.tbl_deepcopy(capabilities) })
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
