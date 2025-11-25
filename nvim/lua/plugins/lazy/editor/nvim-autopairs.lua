local spec = {
  enabled = true,
  'windwp/nvim-autopairs',
  dependencies = {
    'RRethy/nvim-treesitter-endwise'
  },
  event = 'VeryLazy',
  opts = {
    disable_filetype = { 'grug%-far', 'Telescope*' },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    fast_wrap = {
      end_key = 's'
    }
  },
  config = function(_, opts)
    local npairs = require('nvim-autopairs')
    npairs.setup(opts)

    local rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')
    local ts_cond = require('nvim-autopairs.ts-conds')

    npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))

    npairs.add_rules({
      rule('%', '%', 'htmldjango'):with_pair(cond.before_text('{'))
    })

    npairs.add_rules({
      rule('{', '},', 'lua'):with_pair(ts_cond.is_ts_node({ 'table_constructor' })),
      rule("'", "',", 'lua'):with_pair(ts_cond.is_ts_node({ 'table_constructor' })),
      rule('"', '",', 'lua'):with_pair(ts_cond.is_ts_node({ 'table_constructor' }))
    })
  end
}

return spec
