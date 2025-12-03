return {
  --https://github.com/max397574/better-escape.nvim
  'max397574/better-escape.nvim',
  event = 'VeryLazy',
  opts = {
    default_mappings = false,
    mappings = {
      -- i for insert
      i = {
        j = {
          -- These can all also be functions
          k = '<Esc>',
        },
      },
    },
  },
}
