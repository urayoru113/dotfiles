local spec = {
  enabled = false,
  'neoclide/coc.nvim',
  branch = 'release',
  init = function()
    local utils = require('core.utils')
    local keymaps = require('core.keymaps')
    utils.load_mappings(keymaps['cocnvim'])
  end
}

return spec
