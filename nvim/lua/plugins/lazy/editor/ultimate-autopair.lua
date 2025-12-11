local spec = {
  enabled = true,
  'altermo/ultimate-autopair.nvim',
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  branch = 'v0.6', --recommended as each new version will have breaking changes
  opts = {
    --Config goes here
  },
}

return spec
