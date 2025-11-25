local spec = {
  enabled = false,
  init = function()
    vim.g.VM_custom_remaps = { ['<C-c>'] = '<ESC>' }
  end,
  "mg979/vim-visual-multi",
  branch = "master",
}
return spec
