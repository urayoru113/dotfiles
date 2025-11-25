local spec = {
  -- https://github.com/milanglacier/minuet-ai.nvim
  'milanglacier/minuet-ai.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    provider = 'openai_fim_compatible',
    n_completions = 1,
    throttle = 1000,
    request_timeout = 8,
    provider_options = {
      gemini                = {
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
        model = 'codegemma:7b-code-q3_K_S',
        stream = false,
        optional = {
          max_tokens = 56,
          top_p = 0.8,
          stop = '\n\n',
        },
        template = {
          prompt = function(context_before_cursor, context_after_cursor, _)
            -- return '<PRE>' .. context_before_cursor .. '<SUF>' .. context_after_cursor .. '<MID>'
            return '<|fim_prefix|>' ..
                context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
          end,
          suffix = false,
        },
      },
    }
  },
}

return spec
