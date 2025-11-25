return {
  --https://github.com/folke/edgy.nvim
  'folke/edgy.nvim',
  opts = {
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = 'Neo-Tree',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'filesystem'
        end,
        size = { height = 0.5 },
      },
    },
    animate = {
      enabled = false,
    },
  },
}
