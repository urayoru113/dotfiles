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
        deepseek = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            name = 'deepseek',
            formatted_name = 'Deepseek',
            roles = {
              llm = 'assistant',
              user = 'user',
            },
            opts = {
              stream = true,
              tools = true,
            },
            features = {
              text = true,
              tokens = true,
              vision = false,
            },
            env = {
              url = 'http://localhost:11434',
              chat_url = '/v1/chat/completions',
              -- api_key = "",  <-- get from sys env: OPENAI_API_KEY
            },
            schema = {
              model = {
                default = 'deepseek-coder:6.7b-instruct-q4_K_M',
              },
              headers = {
                ['Content-Type'] = 'application/json',
                ['Authorization'] = 'Bearer Unnecessary',
              },
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
        adapter = 'deepseek',
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
