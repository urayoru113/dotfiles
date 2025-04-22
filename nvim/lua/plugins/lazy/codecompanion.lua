local keymaps = {
  close = {
    modes = {
      i = "<C-q>"
    }
  }
}

local spec = {
  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "GEMINI_API_KEY",
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "gemini",
        tools = {
          ["mcp"] = {
            -- calling it in a function would prevent mcphub from being loaded before it's needed
            callback = function() return require("mcphub.extensions.codecompanion") end,
            description = "Call tools and resources from the MCP Servers",
          }
        },
        keymaps = keymaps
      }
    },
    inline = {
      adapter = "gemini",
      keymaps = keymaps,
    },
    prompt_library = {
      ["Code review"] = {
        strategy = "chat",
        description = "Code review in current buffer",
        prompts = {
          {
            role = "system",
            content = function()
              local text = require("codecompanion.helpers.actions").get_code(0, vim.fn.line('$'))
              return
                  "You will be acting as a senior software engineer performing a code review for a colleague.\n" ..
                  "You will follow the guidelines for giving a great code review outlined below:" ..
                  "https://google.github.io/eng-practices/review/reviewer/looking-for.html\n" ..
                  "Here is the proposed code changes you will be reviewing:\n" ..
                  "```\n" ..
                  text ..
                  "```"
            end,
          },
          opts = {
            auto_submit = true,
          }
        },
      }
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

return spec
