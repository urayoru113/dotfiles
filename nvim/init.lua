local utils = require('core.utils')
local autocmds = require('core.autocmds')
local keymaps = require('core.keymaps')

_G.M = {}

utils.load_mappings(keymaps['general'])
utils.load_autocmds('General', autocmds['general'])
utils.load_highlights('general')

require('core')
require('plugins').lazy()
