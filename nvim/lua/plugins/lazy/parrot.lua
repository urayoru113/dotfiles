local opts = {
  -- Providers must be explicitly added to make them available.
  enabled = false,
  providers = {
    gemini = {
      api_key = vim.fn.getenv("GEMINI_API_KEY"),
      topic = {
        model = "gemini-2.0-flash"
      }
    },
  },
  hooks = {
    Translate = function(prt, params)
      local chat_prompt = [[
Please translate the following section into Traditional Chinese:
```
{{selection}}
```
                        ]]
      local model = prt.get_model("chat")
      prt.Prompt(params, prt.ui.Target.new, model, nil, chat_prompt)
    end,
    CodeReview = function(prt, params)
      local chat_prompt = [[
Your task is to analyze the provided {{filetype}} code and suggest
          improvements to optimize its performance. Identify areas where the
          code can be made more efficient, faster, or less resource-intensive.
          Provide specific suggestions for optimization, along with explanations
          of how these changes can enhance the code's performance. The optimized
          code should maintain the same functionality as the original code while
          demonstrating improved efficiency.

Consider:
1. Code quality and adherence to best practices
2. Potential bugs or edge cases
3. Performance optimizations
4. Readability and maintainability
5. Any security concerns
Suggest improvements and explain your reasoning for each suggestion.

Here is the code:
```{{filetype}}
{{filecontent}}
```
                    ]]
      local model = prt.get_model("chat")
      prt.Prompt(params, prt.ui.Target.new, model, nil, chat_prompt)
    end
  }
}
local spec = {
  "frankroeder/parrot.nvim",
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  -- optionally include "folke/noice.nvim" or "rcarriga/nvim-notify" for beautiful notifications
  opts = opts,
}

return spec
