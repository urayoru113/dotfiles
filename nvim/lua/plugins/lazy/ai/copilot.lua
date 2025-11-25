local spec = {
  enabled = false,
  "zbirenbaum/copilot-cmp",
  dependencies = "zbirenbaum/copilot.lua",
  config = function()
    local copilot = require("copilot")
    copilot.setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
      }
    })

    local copilot_cmp = require("copilot_cmp")
    copilot_cmp.setup({
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = true,
    })
  end
}

return spec
