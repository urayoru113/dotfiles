local prompt_config = require('core.config.prompt')
local spec = {
  -- https://github.com/milanglacier/minuet-ai.nvim
  'milanglacier/minuet-ai.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    provider = 'openai_fim_compatible',
    n_completions = 3,
    throttle = 1000,
    request_timeout = 3,
    before_cursor_filter_length = 2,
    after_cursor_filter_length = 15,
    provider_options = {
      gemini = {
        model = 'gemini-2.0-flash',
        optional = {
          generationConfig = {
            maxOutputTokens = 256,
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
              category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
              -- BLOCK_NONE
              threshold = 'BLOCK_ONLY_HIGH',
            },
          },
        },
      },
      openai_fim_compatible = {
        -- For Windows users, TERM may not be present in environment variables.
        -- Consider using APPDATA instead.
        api_key = 'TERM',
        name = 'Ollama',
        end_point = 'http://localhost:11434/v1/completions',
        -- The model is set by the llama-cpp server and cannot be altered
        -- post-launch.
        model = 'deepseek-coder:6.7b-base-q3_K_L',
        stream = true,
        optional = {
          max_tokens = 128,
          top_p = 0.8,
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
}

return spec
