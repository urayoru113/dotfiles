local spec = {
  enabled = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  "nvim-mini/mini.ai",

  config = function()
    local ai = require("mini.ai")
    ai.setup({
      custom_textobjects = {
        -- 基礎結構
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        b = ai.gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }),

        -- 邏輯與迴圈 (注意 conditional 改用 d, loop 改用 o 避開衝突)
        d = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
        o = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
        s = ai.gen_spec.treesitter({ a = "@statement.outer", i = "@statement.outer" }), -- statement 通常沒有 inner

        -- 參數與回傳
        p = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
        r = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }),

        -- 賦值與呼叫
        A = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
        L = ai.gen_spec.treesitter({ a = "@assignment.lhs", i = "@assignment.lhs" }),
        R = ai.gen_spec.treesitter({ a = "@assignment.rhs", i = "@assignment.rhs" }),
        C = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),

        -- 註解與雜項
        m = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
        a = ai.gen_spec.treesitter({ a = "@attribute.outer", i = "@attribute.inner" }),
        F = ai.gen_spec.treesitter({ a = "@frame.outer", i = "@frame.inner" }),
      },
    })
  end,
}

return spec
