local options = {
  size = function(term)
    if term.direction == "horizontal" then
      return 8
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<F7>]],
  shading_factor = 2,
  clear_env = "oierji",
  direction = "float",
  float_opts = {
    border = "curved",
  },
}


local spec = {
  "akinsho/toggleterm.nvim",
  opts = options,
  keys = "<F7>",
  version = '*',
}

return spec

--local Terminal = require('toggleterm.terminal').Terminal
--local custom   = Terminal:new({
--  cmd = "bash",
--  hidden = false,
--  env = {
--    PATH = os.getenv("PATH"),
--    CONDA_DEFAULT_ENV = os.getenv("CONDA_DEFAULT_ENV"),
--    CONDA_PREFIX = os.getenv("CONDA_PREFIX"),
--    CONDA_PROMPT_MODIFIER = os.getenv("CONDA_PROMPT_MODIFIER"),
--    LS_COLORS = os.getenv("LS_COLORS"),
--  },
--  auto_screen = true,
--})
--
--local custom_toggle = function()
--  custom:toggle()
--end
--
--vim.keymap.set(
--  "n",
--  "<F7>",
--  function()
--    custom_toggle()
--  end,
--  { noremap = true, silent = true })
--
--vim.keymap.set(
--  "t",
--  "<F7>",
--  function()
--    custom_toggle()
--  end,
--  { noremap = true, silent = true })
