return {
  -- bug
  {
    enabled = false,
    'jake-stewart/multicursor.nvim',
    config = function()
      local mc = require('multicursor-nvim')
      --local set = vim.keymap.set
      --mc.setup({})

      -- Add or skip cursor above/below the main cursor.
      --set({ 'n', 'x' }, '<C-n>', function() mc.matchAddCursor(1) end, { desc = 'multi cursor' })
    end,
  },
}
