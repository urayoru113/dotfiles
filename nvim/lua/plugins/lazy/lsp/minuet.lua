local prompt_config = require('core.config.prompt')
local spec = {
  -- https://github.com/milanglacier/minuet-ai.nvim
  'milanglacier/minuet-ai.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
  },
  event = { 'InsertEnter' },
  opts = {
    provider = 'openai_fim_compatible',
    n_completions = 3,
    throttle = 1000,
    request_timeout = 3,
    before_cursor_filter_length = 2,
    after_cursor_filter_length = 15,
    provider_options = {
      gemini = {
        model = 'gemini-2.5-flash',
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
        model = 'deepseek-coder:6.7b-base-q3_K_S',
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
    cmp = {
      enable_auto_complete = false,
    },
    blink = {
      enable_auto_complete = true,
    },
  },
  config = function(_, opts)
    local _config = function()
      local is_server_running = function(url)
        local handle = io.popen('curl -s ' .. url .. ' > /dev/null 2>&1 && echo 1 || echo 0')
        assert(handle, '`handle` should not be nil')
        local result = tonumber(handle:read('*a')) -- *a means read whole file
        handle:close()
        return result == 1
      end
      local url = opts.provider_options[opts.provider].end_point
      local base_url = string.match(url, '^(.-)/v1/completions$')
      if is_server_running(base_url) then
        require('minuet').setup(opts)
      else
        vim.notify('Server `' .. base_url .. '` is unreachable', vim.log.levels.WARN)
      end
    end
    vim.schedule(_config)
  end,
}

return spec
