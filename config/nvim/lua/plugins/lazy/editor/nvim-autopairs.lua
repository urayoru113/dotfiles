local spec = {
  enabled = true,
  "windwp/nvim-autopairs",
  dependencies = {
    "rrethy/nvim-treesitter-endwise",
  },
  opts = {
    disable_filetype = { "grug%-far", "telescopeprompt" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = "$",
      before_key = "h",
      after_key = "l",
      cursor_pos_before = true,
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      manual_position = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  },
  event = "insertenter",
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    local rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")
    local ts_cond = require("nvim-autopairs.ts-conds")

    npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))

    npairs.add_rules({
      rule("%", "%", "htmldjango"):with_pair(cond.before_text("{")),
    })

    npairs.add_rules({
      rule("{", "},", "lua"):with_pair(function(options)
        return cond.not_after_text(",")(options) == nil and
            ts_cond.is_ts_node({ "table_constructor" })(options)
      end),
      rule("'", "',", "lua"):with_pair(function(options)
        return cond.not_after_text(",")(options) == nil and
            ts_cond.is_ts_node({ "table_constructor" })(options)
      end),
      rule('"', '",', "lua"):with_pair(function(options)
        return cond.not_after_text(",")(options) == nil and
            ts_cond.is_ts_node({ "table_constructor" })(options)
      end),
    })
  end,
}

return spec
