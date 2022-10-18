local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

local options = {
  sort_by = "case_sensitive",
  open_on_tab = true,
  open_on_setup = true,
  open_on_setup_file = true,
  view = {
    width = 24,
    adaptive_size = true,
    mappings = {
      list = {
        { key = "t", action = "tabnew" },
        { key = "<tab>", action = "" },
        { key = "<2-LeftMouse>", action = "edit" },
      },
    },
  },
  diagnostics = {
    enable = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}

nvimtree.setup(options)

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.fn.winnr('$') == 1 then
      if vim.o.filetype == "NvimTree" then
        vim.fn.execute('q')
      elseif vim.fn.filereadable(vim.fn.expand("%:p")) == 1 then
        --vim.fn.execute('NvimTreeOpen')
        --vim.fn.execute('wincmd p')
      end
    end
  end
})

local api = require('nvim-tree.api')

_G.M.goto_next_page = false

api.events.subscribe(api.events.Event.TreeOpen, function()
  if _G.M.goto_next_page then
    vim.fn.execute("wincmd p")
    _G.M.goto_next_page = false
  end
end)
