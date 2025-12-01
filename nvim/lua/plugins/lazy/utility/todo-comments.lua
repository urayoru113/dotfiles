return {
  'folke/todo-comments.nvim',
  cond = vim.fn.executable('rg'),
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local todo = require('todo-comments')
    todo.setup(opts)
    local has_telescope, telescope = pcall(require, 'telescope')
    if has_telescope then
      telescope.load_extension('todo-comments')
    end
  end,
}
