local options = {
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filetype', { 'filename', path = 1 } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'datetime' },
    lualine_z = { 'progress', 'location' },
  },
  options = {
    theme = 'dracula',
    section_separators = { left = '', right = '' },
  },
  extensions = {
    'quickfix',
    'mason',
    'neo-tree',
    'nvim-tree',
    'nvim-dap-ui',
    'avante',
    'toggleterm',
    'trouble',
  },
}

local spec = {
  'nvim-lualine/lualine.nvim',
  opts = options,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

return spec
