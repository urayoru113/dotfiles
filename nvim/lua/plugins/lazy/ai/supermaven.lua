return {
  "supermaven-inc/supermaven-nvim",
  opts = {
    disable_inline_completion = false,
    keymaps = {
      accept_suggestion = "<C-y>",
      clear_suggestion = nil,
      accept_word = nil,
    },
    disable_keymaps = false,
    condition = function()
      local filename = vim.fn.expand("%:t")
      return filename:match(".env") or filename:match(".secret.sh")
    end,
  },
}
