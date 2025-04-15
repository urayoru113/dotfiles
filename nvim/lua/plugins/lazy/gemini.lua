local spec = {
  'kiddos/gemini.nvim',
  option = {
    completion = {
      enalbed = false,
    }
  },
  config = function(_, opts)
    require('gemini').setup()
  end
}

return spec
