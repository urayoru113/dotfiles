return {
  -- https://github.com/MagicDuck/grug-far.nvim
  'MagicDuck/grug-far.nvim',
  init = function()
    local utils = require('core.utils')
    local keymaps = require('core.keymaps')
    utils.load_mappings(keymaps['grug-far'])
  end,
  opts = {
    keymaps = {
      replace = { n = '<localleader>r' },
      qflist = { n = '<localleader>q' },
      syncLocations = { n = '<localleader>s' },
      syncLine = { n = '<localleader>l' },
      close = { n = 'Q' },
      historyOpen = { n = '<localleader>t' },
      historyAdd = { n = '<localleader>a' },
      refresh = { n = '<localleader>f' },
      openLocation = { n = '<localleader>o' },
      openNextLocation = { n = '<M-j>' },
      openPrevLocation = { n = '<M-k>' },
      gotoLocation = { n = '<enter>' },
      pickHistoryEntry = { n = '<enter>' },
      abort = { n = '<localleader>b' },
      help = { n = 'g?' },
      toggleShowCommand = { n = '<localleader>w' },
      swapEngine = { n = '<localleader>e' },
      previewLocation = { n = '<localleader>i' },
      swapReplacementInterpreter = { n = '<localleader>x' },
      applyNext = { n = '<localleader>j' },
      applyPrev = { n = '<localleader>k' },
      syncNext = { n = '<localleader>n' },
      syncPrev = { n = '<localleader>p' },
      syncFile = { n = '<localleader>v' },
      nextInput = false,
      prevInput = false,
    },
    windowCreationCommand = 'tabnew',
  },
}
