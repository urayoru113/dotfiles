local prompt_config = require("core.config.prompt")

local default_provider = "openrouter"

local spec = {
  --https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
  enabled = true,
  "olimorris/codecompanion.nvim",
  tag = "v18.7.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
  keys = {
    { "<F5>", mode = { "n", "v" }, "<CMD>CodeCompanionChat Toggle<CR>", noremap = true },
    { "<leader>a", mode = { "n", "v" }, "<CMD>CodeCompanionActions<CR>", noremap = true },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionCmd",
    "CodeCompanionActions",
  },
  opts = {
    opts = {
      language = "English",
    },
    display = {
      chat = {
        window = {
          position = "right",
          sticky = true, -- chat buffer remains open when switching tabs
        },
        icons = {
          chat_fold = " ",
        },
        separator = "=",
        fold_reasoning = false,
        show_reasoning = false,
      },
    },
    adapters = {
      http = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemma-4-26b-a4b-it",
                choices = {
                  ["gemma-4-31b-it"] = {
                    formatted_name = "Gemma 4",
                    meta = { context_window = 1048576 },
                    opts = { can_reason = true, has_vision = false },
                  },
                  ["gemma-4-26b-a4b-it"] = {
                    formatted_name = "Gemma 4 MOE",
                    meta = { context_window = 1048576 },
                    opts = { can_reason = true, has_vision = false },
                  },
                },
              },
            },
            opts = {
              stream = true,
              tools = true,
              vision = false,
            },
          })
        end,
        deepseek = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "deepseek",
            formatted_name = "Deepseek",
            roles = {
              llm = "assistant",
              user = "user",
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
              url = "http://localhost:11434",
              chat_url = "/v1/chat/completions",
              -- api_key = "",  <-- get from sys env: OPENAI_API_KEY
            },
            schema = {
              model = {
                default = "qwen3-vl:2b-thinking-bf16",
                choices = {
                  "deepseek-coder:6.7b-instruct-q4_K_M",
                  "ishumilin/deepseek-r1-coder-tools:1.5b",
                },
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer Unnecessary",
              },
            },
          })
        end,
        groq = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = "GROQ_API_KEY",
            },
            url = "https://api.groq.com/openai/v1/chat/completions",
            schema = {
              model = {
                --https://console.groq.com/settings/limits
                default = "meta-llama/llama-4-scout-17b-16e-instruct",
                choices = {
                  "llama-3.3-70b-versatile",
                  "llama-3.1-8b-instant",
                  "mixtral-8x7b-32768",
                  "groq/compound",
                  "qwen/qwen3-32b",
                  "openai/gpt-oss-120b",
                },
              },
              max_tokens = {
                default = 8192,
              },
            },
            temperature = {
              default = 1,
            },
          })
        end,
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            url = "https://openrouter.ai/api/v1/chat/completions",
            env = {
              api_key = "OPENROUTER_API_KEY",
            },
            schema = {
              model = {
                default = "openrouter/free",
                choices = {
                  "deepseek/deepseek-v4-flash:free",
                  "qwen/qwen3-coder:free",
                  "nvidia/nemotron-3-super-120b-a12b:free",
                  "poolside/laguna-m.1:free",
                  "openai/gpt-oss-120b:free",
                },
              },
            },
          })
        end,
        opts = {
          show_presets = true, -- Show preset adapters
        },
      },
      acp = {
        opencode = function()
          return require("codecompanion.adapters").extend("opencode", {
          })
        end,
        opts = {
          show_presets = true, -- Show preset adapters
        },
      },
    },
    interactions = {
      chat = {
        adapter = default_provider,
        keymaps = {
          send = {
            modes = {
              i = "<C-!>",
              n = "<C-s>",
            },
            opts = {},
          },
          close = {
            modes = {
              i = "<C-!>", -- Map an impossible key to disable
              n = "Q",
            },
            callback = function()
              vim.cmd("CodeCompanionChat Toggle")
            end,
          },
        },
        tools = {
          insert_edit_into_file = {
            opts = {
              require_confirmation_after = false,
            },
          },
        },
      },
      inline = {
        adapter = default_provider,
      },
      cmd = {
        adapter = default_provider,
      },
    },
    prompt_library = {
      ["Code review"] = {
        strategy = "chat",
        description = "Code review",
        prompts = {
          {
            role = "system",
            content = function(context)
              return prompt_config.code_review_prompt .. "\n```\n" .. context.code .. "\n```\n"
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
