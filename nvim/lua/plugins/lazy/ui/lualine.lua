local options = {
  sections = {
    lualine_c = { function() return vim.fn.expand("%:p:.") end },
    lualine_y = { "datetime" },
    lualine_z = { "progress", "location" },
  },
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
  },
  extensions = { 'quickfix', 'mason', 'nvim-tree', 'nvim-dap-ui', 'avante', 'toggleterm', 'trouble' }

}

local spec = {
  "nvim-lualine/lualine.nvim",
  opts = options,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

return spec
