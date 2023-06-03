local spec = {
  enabled = false,
  "neoclide/coc.nvim",
  branch = "release",
  init = function()
    require("core.utils").load_mappings("cocnvim")
  end
}

return spec
