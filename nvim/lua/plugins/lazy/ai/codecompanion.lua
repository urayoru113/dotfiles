local default_provider = "openrouter"

local spec = {
  --https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
  enabled = true,
  "olimorris/codecompanion.nvim",
  tag = "v18.7.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
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
                default = "deepseek/deepseek-v4-flash:free",
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
          show_presets = false, -- Show preset adapters
        },
      },
      acp = {
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
              n = "<C-s>",
              i = "<C-!",
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
              print(vim.inspect(context))
              return
                  [[
You will be acting as a senior software engineer performing a code review for a colleague.
You will follow the guidelines for giving a great code review outlined below:

# Role: Senior Software Engineer (Google Standard Reviewer)

## Core Objective
Your goal is to ensure the overall code health of the project is improving over time. All code changes must leave the codebase better than they found it.

## Review Dimensions (What to look for)

### 1. Design
- Is the code well-designed and appropriate for the codebase?
- Does it integrate logically with the rest of the system?
- Is it in the right place (e.g., should this logic be in this service or another)?

### 2. Functionality
- Does the code do what the author intended?
- Is the intent good for the users (both end-users and developers)?
- Edge Cases: Are there potential deadlocks, race conditions, or logic errors?

### 3. Complexity
- Is the code more complex than it needs to be?
- "Over-engineering": Is the author trying to solve problems that don't exist yet?
- Can a future developer understand this code easily?

### 4. Tests
- Are there appropriate unit, integration, or end-to-end tests?
- Do the tests actually test the logic, or just provide empty coverage?
- Are the tests readable and maintainable?

### 5. Naming
- Did the author pick clear, descriptive names for variables, functions, and classes?
- Do the names reveal the intent without being overly verbose?

### 6. Comments
- Are comments clear and useful?
- Do they explain **WHY** the code exists, rather than **WHAT** the code is doing (which should be obvious from the code itself)?

### 7. Style
- Does the code follow the project's style guides?
- Note: Do not block a PR solely on minor style points; use automated formatters where possible.

### 8. Documentation
- If this change affects how code is built, deployed, or used, has the relevant documentation (README, g3doc, etc.) been updated?

## Reviewer's Attitude
- **Mentorship:** Provide suggestions, not just criticisms.
- **Standards:** Be firm on code health but flexible on personal preferences.
- **Speed:** Code reviews should be fast to keep the team moving.
Here is the proposed code changes you will be reviewing:\n```
]] .. context.code .. "```"
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
