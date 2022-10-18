local utils = require("core.utils")
local mappings = utils.load_config().mappings
utils.load_mappings("general")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
  end
})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = {"python"},
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
  end
})


function ShowDocumentation()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocAction('doHover')
  else
    vim.fn.feedkeys('K', 'in')
  end
end
vim.keymap.set('n', 'K', function() ShowDocumentation() end, { noremap = true, silent = true })

local clip = '/mnt/c/Windows/System32/clip.exe'
local win32yank = '/mnt/c/Windows/System32/win32yank.exe'
if vim.fn.executable(win32yank) then
  vim.api.nvim_create_augroup('WSLYank', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'WSLYank',
    pattern = '*',
    callback = function()
      vim.fn.system(win32yank .. ' -i --crlf', vim.fn.getreg('"'))
    end
  })
  vim.keymap.set('n', 'p', ':let @" = system("' .. win32yank .. ' -o --lf")<CR>p', { noremap = true })
  vim.keymap.set('x', 'p', '<ESC><ESC>:let @" = system("' .. win32yank .. ' -o --lf")<CR>gvp', { noremap = true })
elseif vim.fn.executable(clip) then
  vim.api.nvim_create_augroup('WSLYank', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'WSLYank',
    pattern = '*',
    callback = function()
      vim.fn.system(clip, vim.fn.getreg('"'))
    end
  })
end

vim.cmd([[

" Get current cursor bypassing unicode"
function! GetCursorChar()
  return matchstr(getline("."), '\%'.col(".").'c.')
endfunction

let c='a'
while c <= 'z'
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

highlight Pmenu None
highlight SplashAuthor ctermfg=66 guifg=#6d8086

syntax enable

]])
