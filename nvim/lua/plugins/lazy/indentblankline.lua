--vim.g.indent_blankline_char = "￤"

local spec = {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    vim.api.nvim_set_hl(
      0,
      "IndentBlanklineChar",
      { fg = "#666666", nocombine = true }
    )
  end,
}

return spec
