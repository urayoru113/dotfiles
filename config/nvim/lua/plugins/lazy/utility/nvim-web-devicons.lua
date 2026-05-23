local options = {
  color_icons = true,
  default = true,
}

local spec = {
  url = "https://github.com/nvim-tree/nvim-web-devicons.git",
  'nvim-tree/nvim-web-devicons',
  opts = options,
  config = function(_, opts)
    local nvim_web_devicons = require("nvim-web-devicons")
    nvim_web_devicons.setup(opts)
    nvim_web_devicons.set_icon({
      DapBreakpoint = {
        icon = '',
        color = '#e03030',
        name = 'DapBreakpoint'
      },
      DapStopped = {
        icon = '',
        color = '#25af80',
        name = 'DapStopped'
      }
    })
  end
}

return spec
