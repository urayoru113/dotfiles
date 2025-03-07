-- https://github.com/akinsho/bufferline.nvim
local options = {
  options = {
    mode = 'tabs',
    tab_size = 10,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        highlight = "Directory",
        separator = true
      },
      indicator = {
        style = 'underline'
      },
    },
    separator_style = 'slant',
    show_tab_indicators = false,
  },
  highlights = {
  },
}

local spec = {
  'akinsho/bufferline.nvim',
  version = "*",
  opts = options,
  dependencies = 'nvim-tree/nvim-web-devicons',
  ft = "NvimTree"
}

return spec
