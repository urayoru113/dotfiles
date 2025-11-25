return {
  enabled = false,
  'frankroeder/parrot.nvim',
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  -- optionally include "folke/noice.nvim" or "rcarriga/nvim-notify" for beautiful notifications
  config = function()
    require('parrot').setup {
      -- Providers must be explicitly set up to make them available.
      providers = {
        ollama = {
          name = 'ollama',
          endpoint = 'http://localhost:11434/v1/completions',
          api_key = '', -- not required for local Ollama
          params = {
            chat = { temperature = 1.5, top_p = 1, num_ctx = 8192, min_p = 0.05 },
            command = { temperature = 1.5, top_p = 1, num_ctx = 8192, min_p = 0.05 },
          },
          topic_prompt = [[
    Summarize the chat above and only provide a short headline of 2 to 3
    words without any opening phrase like "Sure, here is the summary",
    "Sure! Here's a shortheadline summarizing the chat" or anything similar.
    ]],
          topic = {
            model = 'codegemma:code',
            params = { max_tokens = 32 },
          },
          headers = {
            ['Content-Type'] = 'application/json',
          },
          models = {
            'codegemma:code',
          },
          resolve_api_key = function()
            return true
          end,
          process_stdout = function(response)
            if response:match 'message' and response:match 'content' then
              local ok, data = pcall(vim.json.decode, response)
              if ok and data.message and data.message.content then
                return data.message.content
              end
            end
          end,
        },
      },
    }
  end,
}
