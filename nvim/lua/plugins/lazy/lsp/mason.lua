local spec = {
  "williamboman/mason.nvim",
  init = function()
    require("core.utils").load_mappings("lspsaga")
  end,
  opts = {},
  build = ":MasonUpdate",
}

return spec
