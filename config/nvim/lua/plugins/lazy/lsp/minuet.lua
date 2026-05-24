local prompt_config = require("core.config.prompt")

local spec = {
  -- https://github.com/milanglacier/minuet-ai.nvim
  enabled = false,
  "milanglacier/minuet-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
  },
  event = { "InsertEnter" },
  opts = {
    provider = "gemini",
    n_completions = 2,
    throttle = 1000,
    request_timeout = 3,
    before_cursor_filter_length = 2,
    after_cursor_filter_length = 15,
    provider_options = {
      gemini = {
        model = "gemini-3.1-flash-light",
        stream = true,
        optional = {
          generationConfig = {
            maxOutputTokens = 128,
            -- When using `gemini-2.5-flash`, it is recommended to entirely
            -- disable thinking for faster completion retrieval.
            thinkingConfig = {
              thinkingBudget = 0,
            },
          },
          safetySettings = {
            {
              -- HARM_CATEGORY_HATE_SPEECH,
              -- HARM_CATEGORY_HARASSMENT
              -- HARM_CATEGORY_SEXUALLY_EXPLICIT
              category = "HARM_CATEGORY_DANGEROUS_CONTENT",
              -- BLOCK_NONE
              threshold = "BLOCK_ONLY_HIGH",
            },
          },
        },
      },

    },
    cmp = {
      enable_auto_complete = false,
    },
    blink = {
      enable_auto_complete = true,
    },
    presets = {
      ollama = {
        provider = "openai_fim_compatible",
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "deepseek-coder:6.7b-base-q3_K_S",
            stream = true,
            optional = {
              max_tokens = 128,
              temperature = 0.3,
              top_p = 0.9,
              top_k = 20,
            },
            template = {
              prompt = function(...)
                return prompt_config.get_deepseek_fim(...)
              end,
              suffix = false,
            },
          },
        },
      },
      groq = {
        provider = "openai_compatible",
        provider_options = {
          openai_compatible = {
            name = "Groq",
            api_key = "GROQ_API_KEY",
            end_point = "https://api.groq.com/openai/v1/chat/completions",
            model = "qwen/qwen3-32b",
            stream = true,
            optional = {
              max_tokens = 256,
              temperature = 0.7,
              top_p = 0.9,
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    local minuet = require("minuet")
    minuet.setup(opts)
    minuet.change_preset("groq")
  end,
}

return spec
