local utils = require("core.utils")

local autocmd = vim.api.nvim_create_autocmd

-- Use K to show documentation in preview window.
function _G.show_docs()
  local cw = vim.fn.expand("<cword>")
  if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command("h " .. cw)
  elseif vim.api.nvim_eval("coc#rpc#ready()") then
    vim.fn.CocActionAsync("doHover")
  else
    vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
  end
end

local function share_clipboard()
  local clip = "/mnt/c/Windows/System32/clip.exe"
  local win32yank = "/mnt/c/Windows/System32/win32yank.exe"
  if vim.fn.executable(win32yank) == 1 then
    vim.api.nvim_create_augroup("WSLYank", { clear = true })
    autocmd("TextYankPost", {
      group = "WSLYank",
      pattern = "*",
      callback = function()
        vim.fn.system(win32yank .. " -i --crlf", vim.fn.getreg('"'))
      end,
    })
    vim.keymap.set(
      "n",
      "p",
      ':let @" = system("' .. win32yank .. ' -o --lf")<CR>p',
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "P",
      ':let @" = system("' .. win32yank .. ' -o --lf")<CR>P',
      { noremap = true, silent = true }
    )
    vim.keymap.set("x", "p", '<ESC><ESC>:let @" = system("' .. win32yank .. ' -o --lf")<CR>gvp', { noremap = true })
  elseif vim.fn.executable(clip) == 1 then
    vim.api.nvim_create_augroup("WSLYank", { clear = true })
    autocmd("TextYankPost", {
      group = "WSLYank",
      pattern = "*",
      callback = function()
        vim.fn.system(clip, vim.fn.getreg('"'))
      end,
    })
  end
end

local function vim_cmd()
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

  syntax enable
  ]])
end

local function lsp_setup()
  local diagnostic_config = require("core.config.diagnostic")
  local dap_config = require("core.config.dapconf")
  for _, sign in ipairs(diagnostic_config.signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config(diagnostic_config.config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    focusable = false,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  for _, sign in ipairs(dap_config.signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.texthl, text = sign.text, numhl = "" })
  end
end

_G.python_path = vim.fn.exepath("python")
_G.venv_path = vim.fn.getenv("VIRTUAL_ENV")

vim.g.python3_host_prog = _G.python_path
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.ftplugin_sql_omni_key = "<C-j>"

share_clipboard()
vim_cmd()
lsp_setup()

utils.load_mappings("general")
utils.load_autocmds("general")
utils.load_highlights("general")

require("core.options")
