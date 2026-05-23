local prompt_config = require("core.config.prompt")

local default_provider = "openrouter"

local spec = {
  --https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
  enabled = true,
  "olimorris/codecompanion.nvim",
  version = "v19.*",
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
    "CodeCompanionActions",
    "CodeCompanionCLI",
    "CodeCompanionChat",
    "CodeCompanionCmd",
    "CodeCompanionHistory",
    "CodeCompanionSummaries",
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
        fold_reasoning = true,
        show_reasoning = true,
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
                  "qwen3-vl:2b-thinking-bf16",
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
                  "meta-llama/llama-4-scout-17b-16e-instruct",
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
                  "openrouter/free",
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
          show_model_choices = true,
          show_presets = true, -- Show preset adapters
        },
      },
      acp = {
        hermes = function()
          local helpers = require("codecompanion.adapters.acp.helpers")
          return {
            name = "hermes",
            formatted_name = "Hermes",
            type = "acp",
            roles = {
              llm = "assistant",
              user = "user",
            },
            commands = {
              default = {
                "hermes",
                "acp",
              },
            },
            defaults = {
              mcpServers = {},
              timeout = 20000,
            },
            parameters = {
              protocolVersion = 1,
              clientCapabilities = {
                fs = { readTextFile = true, writeTextFile = true },
              },
              clientInfo = {
                name = "CodeCompanion.nvim",
                version = "1.0.0",
              },
            },
            handlers = {
              setup = function(self)
                return true
              end,
              auth = function(self)
                return true
              end,
              form_messages = function(self, messages, capabilities)
                return helpers.form_messages(self, messages, capabilities)
              end,
              on_exit = function(self, code) end,
            },
          }
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
          codeblock = {
            modes = {
              n = "gcb",
            },
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

    extensions = {
      history = {
        enabled = true,
        opts = {
          auto_save = true,
          continue_last_chat = true,
          delete_on_clearing_chat = true,
          keymap = "gh",
          picker = "telescope",
          auto_generate_title = false,
          chat_filter = function(chat_data)
            return chat_data.cwd == vim.fn.getcwd()
          end,
        },
        summary = {
          -- Keymap to generate summary for current chat (default: "gcs")
          create_summary_keymap = "gcs",
          -- Keymap to browse summaries (default: "gbs")
          browse_summaries_keymap = "gbs",

          generation_opts = {
            adapter = nil,               -- defaults to current chat adapter
            model = nil,                 -- defaults to current chat model
            context_size = 90000,        -- max tokens that the model supports
            include_references = true,   -- include slash command content
            include_tool_outputs = true, -- include tool execution results
            system_prompt = nil,         -- custom system prompt (string or function)
            format_summary = nil,        -- custom function to format generated summary e.g to remove <think/> tags from summary
          },
        },
        -- Memory system (requires VectorCode CLI)
        memory = {
          -- Automatically index summaries when they are generated
          auto_create_memories_on_summary_generation = true,
          -- Path to the VectorCode executable
          vectorcode_exe = "vectorcode",
          -- Tool configuration
          tool_opts = {
            -- Default number of memories to retrieve
            default_num = 10,
          },
          -- Enable notifications for indexing progress
          notify = true,
          -- Index all existing memories on startup
          -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
          index_on_startup = false,
        },
      },
    },
    rules = {
      default = {
        description = "Collection of common files for all projects",
        files = {
          ".clinerules",
          ".cursorrules",
          ".goosehints",
          ".rules",
          ".windsurfrules",
          ".github/copilot-instructions.md",
          "AGENT.md",
          "AGENTS.md",
          "~/.dotfiles/ai/rules/AGENTS.md",
          { path = "CLAUDE.md", parser = "claude" },
          { path = "CLAUDE.local.md", parser = "claude" },
          { path = "~/.claude/CLAUDE.md", parser = "claude" },
        },
      },
    },
  },
}

return spec
