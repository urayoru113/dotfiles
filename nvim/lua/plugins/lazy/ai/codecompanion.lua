local spec = {
  --https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
  enabled = true,
  'olimorris/codecompanion.nvim',
  tag = 'v17.33.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<F5>', mode = { 'n', 'v' }, '<CMD>CodeCompanionChat Toggle<CR>', noremap = true },
    { '<leader>a', mode = { 'n', 'v' }, '<CMD>CodeCompanionActions<CR>', noremap = true },
  },
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionCmd',
    'CodeCompanionActions',
  },
  opts = {
    opts = {
      language = 'English',
    },
    display = {
      chat = {
        window = {
          position = 'right',
          sticky = true, -- chat buffer remains open when switching tabs
        },
        separator = '=',
      },
    },
    adapters = {
      http = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            model = 'gpt-oss:20b',
            formatted_name = "Ollama",
            url = '${url}/v1/chat/completions',
            env = {
              url = 'http://localhost:11434',
              api_key = function() return '' end,
            },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer Unnecessary',
            },
            parameters = {
              sync = true,
            },
          })
        end,
        opts = {
          show_defaults = false,
        },
      },
      acp = {
        opts = {
          show_defaults = false,
        },
      },
    },
    strategies = {
      chat = {
        adapter = 'gemini',
        keymaps = {
          send = {
            modes = {
              n = '<C-s>',
              i = '<C-!',
            },
            opts = {},
          },
          close = {
            modes = {
              i = '<C-!>', -- Map a impossible key to disable
              n = 'Q',
            },
            callback = function()
              vim.cmd('CodeCompanionChat Toggle')
            end,
          },
        },
      },
      inline = {
        adapter = 'gemini',
      },
      cmd = {
        adapter = 'gemini',
      },
    },
    prompt_library = {
      ['Code review'] = {
        strategy = 'chat',
        description = 'Code review',
        prompts = {
          {
            role = 'system',
            content = function(context)
              return
                  'You will be acting as a senior software engineer performing a code review for a colleague.\n' ..
                  'You will follow the guidelines for giving a great code review outlined below:' ..
                  'https://google.github.io/eng-practices/review/reviewer/looking-for.html\n' ..
                  'Here is the proposed code changes you will be reviewing:\n' ..
                  '```\n' ..
                  context.lines
                  '```'
            end,
            opts = {
              ignore_system_prompt = true,
            },
          },
        },
      },
    },
  },
}

return spec
