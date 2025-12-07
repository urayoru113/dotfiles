local utils = require('core.utils')

local autocmd = vim.api.nvim_create_autocmd

local function setup_basic()
  vim.loader.enable()
end

local function setup_debug()
  require('core.config.debug').__set_up_cmd()
  -- legacy
  -- vim.cmd([[
  -- " Get current cursor bypassing unicode"
  -- function! GetCursorChar()
  --   return matchstr(getline("."), '\%'.col(".").'c.')
  -- endfunction

  -- let c='a'
  -- while c <= 'z'
  --   exec "imap \e".c." <A-".c.">"
  --   let c = nr2char(1+char2nr(c))
  -- endw

  -- " syntax enable
  -- ]])
  vim.fn.dump_table = function(data_table)
    local formatted_data = vim.inspect(data_table)

    vim.cmd('tabnew')
    local bufnr = vim.api.nvim_get_current_buf()

    local function set_buf_opt(key, value)
      vim.api.nvim_set_option_value(key, value, { buf = bufnr })
    end

    set_buf_opt('buftype', 'nofile')
    set_buf_opt('bufhidden', 'wipe')
    set_buf_opt('buflisted', false)
    set_buf_opt('swapfile', false)
    set_buf_opt('modifiable', true)

    vim.api.nvim_set_option_value('winbar', '', { win = 0 })

    local lines = vim.split(formatted_data, '\n', {})
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

    set_buf_opt('modifiable', false)
    set_buf_opt('readonly', true)

    vim.api.nvim_set_option_value('number', false, { win = 0 })
    vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
  end
end


local function setup_lsp()
  local diagnostic_config = require('core.config.diagnostic')
  local dap_config = require('core.config.dapconf')
  local lsp_config = require('core.config.lsp')

  vim.diagnostic.config(diagnostic_config.config)

  for _, sign in ipairs(dap_config.signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.texthl, text = sign.text, numhl = '' })
  end

  for provider, config in pairs(lsp_config.providers) do
    if not config.settings then
      config.settings = {}
    end
    vim.lsp.config(provider, config)
    vim.lsp.enable(provider)
  end
end

vim.g.python3_host_prog = utils.get_project_python_path()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.ftplugin_sql_omni_key = '<C-j>'
vim.g.clipboard = 'win32yank'
vim.b.do_format = false

setup_basic()
setup_debug()
setup_lsp()
