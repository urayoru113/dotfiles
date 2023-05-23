local utils = require("core.utils")
local autocmd = vim.api.nvim_create_autocmd

utils.load_mappings("general")

autocmd("VimEnter", {
  callback = function()
  end
})
autocmd("Filetype", {
  pattern = { "python" },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    utils.load_mappings("python")
  end
})
autocmd("Filetype", {
  pattern = { "c" },
  callback = function()
    utils.load_mappings('c')
  end
})
autocmd("Filetype", {
  pattern = { "cpp" },
  callback = function()
    utils.load_mappings('cpp')
  end
})


-- Use K to show documentation in preview window.
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

local clip = '/mnt/c/Windows/System32/clip.exe'
local win32yank = '/mnt/c/Windows/System32/win32yank.exe'
if vim.fn.executable(win32yank) then
  vim.api.nvim_create_augroup('WSLYank', { clear = true })
  autocmd('TextYankPost', {
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
  autocmd('TextYankPost', {
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
highlight LineNrAbove ctermfg=Green guifg=#00ff00
highlight LineNrBelow ctermfg=Red guifg=#ff0000

syntax enable

]])
