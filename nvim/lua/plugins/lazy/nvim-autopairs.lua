local options = {
  fast_wrap = {
    end_key = "s",
  },
  map_cr = true,
}

local spec = {
  {
    "windwp/nvim-autopairs",
    opts = options,
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      local rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      local ts_cond = require("nvim-autopairs.ts-conds")

      npairs.add_rules({
        rule("%", "%", "htmldjango"):with_pair(cond.before_text("{")),
      })
      npairs.add_rules({
        rule(" then", "end", "lua"):end_wise(function()
          return ts_cond.is_ts_node({ "if_statement" })
        end),
        rule(" do", "end", "lua"):end_wise(function()
          return ts_cond.is_ts_node({ "for_statement" })
        end),
        rule(")", "end", "lua"):end_wise(function()
          return ts_cond.is_ts_node({ "function" })
        end),
      })
    end,
  },
}

return spec
