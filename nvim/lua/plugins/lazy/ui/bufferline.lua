-- https://github.com/akinsho/bufferline.nvim

local spec = {
  'akinsho/bufferline.nvim',
  version = 'v4.*',
  opts = {
    options = {
      mode = 'tabs',
      tab_size = 10,
      offsets = {
        {
          filetype = 'neo-tree',
          text = function()
            return vim.fn.getcwd()
          end,
          text_align = 'center',
          highlight = 'Directory',
          separator = true,
        },
        indicator = {
          style = 'underline',
        },
      },
      separator_style = 'slant',
      show_tab_indicators = false,
      custom_filter = function(bufnr, _)
        local unwanted_to_see = require('core.config.ui').unwanted_to_see
        if not unwanted_to_see[vim.bo[bufnr].filetype] then
          return true
        end
      end,
    },
    highlights = {
    },
  },
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
}

return spec
