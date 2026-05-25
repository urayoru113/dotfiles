-- Override codeium.util.get_other_documents and codeium.blink.get_completions to exclude .env files
-- from being sent to Codeium's server for privacy reasons
local util = require("codeium.util")
local blink = require("codeium.blink")

local super_get_completions = blink.get_completions

util.get_other_documents = function(bufnr)
  local other_documents = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" and buf ~= bufnr then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if not bufname:match("%.env$") then
        table.insert(other_documents, {
          editor_language = vim.bo[buf].filetype,
          language = (require("codeium.enums").languages[vim.bo[buf].filetype] or require("codeium.enums").languages.unspecified),
          text = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, true), "\n"),
          line_ending = util.get_newline(buf),
          absolute_uri = util.get_uri(bufname),
        })
      end
    end
  end
  return other_documents
end

blink.get_completions = function(...)
  local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  if not bufname:match("%.env$") then
    return super_get_completions(...)
  end
end
