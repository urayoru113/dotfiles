return {
  'j-hui/fidget.nvim',
  enabled = true,
  opts = {
    progress = {
      display = {
        done_ttl = 5,
        default_format_message = function(msg)
          local message = msg.message
          if not message then
            message = msg.done and 'Completed' or 'In progress...'
          end
          if msg.percentage ~= nil then
            message = string.format('%s (%.0f%%)', msg.percentage, message)
          end
          return message
        end,
      },
    },
  },
}
