local M = {}
local utils = require('core.utils')

M.providers = {
  emmylua_ls = {
    settings = {
      emmylua = {
        runtime = {
          version = 'LuaJIT',
          pathStrict = false,
          requirePattern = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        completion = {
          enable = true,
          callSnippet = true,
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
            --vim.fn.stdpath('data') .. '/lazy',
          },
        },
        diagnostics = {
          globals = { 'vim' },
        },
        hint = {
          enable = true,
        },
        strict = {
          requirePath = true,
        },
      },
    },
  },
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path == vim.fn.stdpath('config') or string.match(path, '/dotfiles$') then
          table.insert(client.config.settings.Lua.workspace.library, vim.fn.stdpath('data') .. '/lazy')
        end
      end
    end,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          pathStrict = false,
          path = {
            'lua/?/init.lua',
            'lua/?.lua',
          },
        },
        diagnostics = {
          globals = { 'vim' },
          libraryFiles = 'Disable',
          workspaceDelay = 100,
        },
        completion = {
          enable = true,
          displayContext = 10,
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = 'Disable',
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          },
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = 'space',
            indent_size = '4',
            quote_style = 'single',
            call_arg_parentheses = 'keep',
            trailing_table_separator = 'smart',
            align_call_args = 'true',
            align_function_params = 'true',
            align_continuous_assign_statement = 'false',
            align_continuous_rect_table_field = 'false',
            align_array_table = 'false',
          },
        },
        hint = {
          enable = true,
        },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        disableLanguageServices = true,
        analysis = {
          autoImportCompletions = true,
          disableOrganizeImports = false,
          diagnosticMode = 'workspace',
          diagnosticSeverityOverrides = {
          },
        },
        pythonPath = utils.get_project_python_path(),
        venvPath = utils.get_project_venv_path('python'),
      },
    },
  },
  -- basedpyright = {
  --   settings = {
  --     basedpyright = {
  --       reportAny = false,
  --       analysis = {
  --         autoImportCompletions = true,
  --         diagnosticMode = "workspace",
  --         logLevel = "Warning",
  --         diagnosticSeverityOverrides = {
  --         }
  --       },
  --       disableOrganizeImports = false,
  --       autoSearchPaths = true,
  --       pythonPath = utils.get_project_python_path(),
  --       venvPath = utils.get_project_venv_path("python"),
  --     }
  --   },
  -- },
  ruff = {
    on_attach = function(client)
      client.server_capabilities.hoverProvider = false
    end,
    settings = {
      --configuration = vim.fn.expand("%:p:h") .. "pyproject.toml",
      configurationPreference = 'filesystemFirst',
      lineLength = 120,
      lint = {
        extendSelect = {
          -- https://docs.astral.sh/ruff/rules/
          'ASYNC', -- flake8-async
          'B',     -- flake8-bugbear
          'C4',    -- flake8-comprehensions
          'C90',   -- mccabe
          'COM',   -- flake8-commas
          'D',     -- pydocstyle
          'DTZ',   -- flake8-datetimez
          'E',     -- pycodestyle Error
          'F',     -- pyflakes
          'FLY',   -- flynt
          'G',     -- flake8-logging-format
          'I',     -- isort
          'ISC',   -- flake8-implicit-str-concat
          'PIE',   -- flake8-pie
          'PLC',   -- Pylint Convention
          'PLE',   -- Pylint Error
          'PLW',   -- Pylint Warning
          'RET',   -- flake8-return
          'RUF',   -- Ruff-specific rules
          'RSE',   -- flake8-raise
          'SIM',   -- flake8-simplify
          'TC',    -- flake8-type-checking
          'TID',   -- flake8-tidy-imports
          'UP',    -- pyupgrade
          'W',     -- pycodestyle Warning
          'YTT',   -- flake8-2020
        },
        ignore = {
          'E741', -- Ambiguous variable name isn't a huge problem
          'B008', -- Do not perform function calls in argument defaults
          'B011', -- Allow `assert false`. We don't use `python -O`
          'B028', -- We don't need explicit `stacklevel` for warnings
          'D100', -- Docstring stuff
          'D101',
          'D102',
          'D104',
          'D105',
          'D107',
          'D203',
          'D213',
          'D401',
          'D402',
          'DTZ005', -- Allow `datetime.datetime.now()` to be called without a `tz` argument
          'E402',   -- Simplified black ignore config to make VSCode happy
          'E501',
          'E701',
          'E731',
          'C408',
          'E203',
          'G004',    -- Ignore `Logging statement uses f-string` warning
          'RET505',  -- Allow unnecessary `elif` after `return` statement
          'D106',    -- Allow undocumented public nested class
          'D205',    -- No blank line required after summary
          'PLW2901', -- Allow overwriting variables in loops ,
        },
        unfixable = {
          'F401',
          'F841', -- Unused local variable
          'F601', -- Dictionary key literal repeated
          'F602', -- Dictionary key repeated
          'B018', -- Useless expression
        },
      },
    },
  },
  bashls = {
    filetypes = {
      'bash',
      'zsh',
      'sh',
    },
  },
}

M.kind_icons = {
  TabNine = '',
  Copilot = '',
  Snippet = '',
  claude = '󰋦',
  openai = '󱢆',
  codestral = '󱎥',
  gemini = '',
  Groq = '',
  Openrouter = '󱂇',
  Ollama = '󰳆',
  ['Llama.cpp'] = '󰳆',
  Deepseek = '',
}

M.kind_menus = {
  nvim_lsp = '[LSP]',
  luasnip = '[Snippet]',
  buffer = '[Buf]',
  path = '[Path]',
  cmp_tabnine = '[TN]',
  copilot = '[Co]',
  cmdline = '[CMD]',
  dap = '[DAP]',
  nvim_lsp_signature_help = '[SIG]',
  tmux = '[TMUX]',
  codecompanion = '[CC]',
}

return M
