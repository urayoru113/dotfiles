return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  branch = "main",
  keys = function()
    local function select_textobject(query, group)
      return function()
        require("nvim-treesitter-textobjects.select").select_textobject(query, group)
      end
    end
    local move_textobject = function(func_name, query, group)
      return function()
        local func = require("nvim-treesitter-textobjects.move")[func_name]
        func(query, group)
      end
    end

    return {
      -- ==========================================================
      -- 🎯 Select (Textobjects - Core selections)
      -- ==========================================================
      { "ic", select_textobject("@class.inner", "textobjects"), mode = { "o", "x" }, desc = "inner class body" },
      { "ac", select_textobject("@class.outer", "textobjects"), mode = { "o", "x" }, desc = "around class definition" },
      { "if", select_textobject("@function.inner", "textobjects"), mode = { "o", "x" }, desc = "inner function body" },
      { "af", select_textobject("@function.outer", "textobjects"), mode = { "o", "x" }, desc = "around function definition" },
      { "ib", select_textobject("@block.inner", "textobjects"), mode = { "o", "x" }, desc = "inner block body" },
      { "ab", select_textobject("@block.outer", "textobjects"), mode = { "o", "x" }, desc = "around block/scope" },
      { "as", select_textobject("@statement.outer", "textobjects"), mode = { "o", "x" }, desc = "around statement" },
      { "id", select_textobject("@conditional.inner", "textobjects"), mode = { "o", "x" }, desc = "inner conditional logic" },
      { "ad", select_textobject("@conditional.outer", "textobjects"), mode = { "o", "x" }, desc = "around conditional (if/else)" },
      { "il", select_textobject("@loop.inner", "textobjects"), mode = { "o", "x" }, desc = "inner loop body" },
      { "al", select_textobject("@loop.outer", "textobjects"), mode = { "o", "x" }, desc = "around loop (for/while)" },
      { "ip", select_textobject("@parameter.inner", "textobjects"), mode = { "o", "x" }, desc = "inner parameters/args" },
      { "ap", select_textobject("@parameter.outer", "textobjects"), mode = { "o", "x" }, desc = "around parameter list" },
      { "ir", select_textobject("@return.inner", "textobjects"), mode = { "o", "x" }, desc = "inner return value" },
      { "ar", select_textobject("@return.outer", "textobjects"), mode = { "o", "x" }, desc = "around return statement" },
      { "ia", select_textobject("@attribute.inner", "textobjects"), mode = { "o", "x" }, desc = "inner attribute value" },
      { "aa", select_textobject("@attribute.outer", "textobjects"), mode = { "o", "x" }, desc = "around attribute/annotation" },
      { "ix", select_textobject("@regex.inner", "textobjects"), mode = { "o", "x" }, desc = "inner regex pattern" },
      { "ax", select_textobject("@regex.outer", "textobjects"), mode = { "o", "x" }, desc = "around regex pattern" },
      { "iC", select_textobject("@call.inner", "textobjects"), mode = { "o", "x" }, desc = "inner function call arguments" },
      { "aC", select_textobject("@call.outer", "textobjects"), mode = { "o", "x" }, desc = "around function call" },
      { "im", select_textobject("@comment.inner", "textobjects"), mode = { "o", "x" }, desc = "inner comment content" },
      { "am", select_textobject("@comment.outer", "textobjects"), mode = { "o", "x" }, desc = "around comment block" },
      { "iF", select_textobject("@frame.inner", "textobjects"), mode = { "o", "x" }, desc = "inner frame body" },
      { "aF", select_textobject("@frame.outer", "textobjects"), mode = { "o", "x" }, desc = "around frame definition" },
      { "iA", select_textobject("@assignment.inner", "textobjects"), mode = { "o", "x" }, desc = "inner assignment expression" },
      { "aA", select_textobject("@assignment.outer", "textobjects"), mode = { "o", "x" }, desc = "around assignment" },
      { "L", select_textobject("@assignment.lhs", "textobjects"), mode = { "o", "x" }, desc = "assignment lhs" },
      { "R", select_textobject("@assignment.rhs", "textobjects"), mode = { "o", "x" }, desc = "assignment rhs" },
      { "in", select_textobject("@number.inner", "textobjects"), mode = { "o", "x" }, desc = "inner number" },
      { "iS", select_textobject("@scopename.inner", "textobjects"), mode = { "o", "x" }, desc = "inner scope name" },

      -- ==========================================================
      -- 🚀 Move Start (Jump to the beginning: Using [ and ])
      -- ==========================================================
      { "]c", move_textobject("goto_next_start", "@class.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next class start" },
      { "[c", move_textobject("goto_previous_start", "@class.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous class start" },
      { "]f", move_textobject("goto_next_start", "@function.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next function start" },
      { "[f", move_textobject("goto_previous_start", "@function.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous function start" },
      { "]b", move_textobject("goto_next_start", "@block.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next block start" },
      { "[b", move_textobject("goto_previous_start", "@block.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous block start" },
      { "]s", move_textobject("goto_next_start", "@statement.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next statement start" },
      { "[s", move_textobject("goto_previous_start", "@statement.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous statement start" },
      { "]d", move_textobject("goto_next_start", "@conditional.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next conditional start" },
      { "[d", move_textobject("goto_previous_start", "@conditional.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous conditional start" },
      { "]l", move_textobject("goto_next_start", "@loop.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next loop start" },
      { "[l", move_textobject("goto_previous_start", "@loop.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous loop start" },
      { "]p", move_textobject("goto_next_start", "@parameter.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next parameter start" },
      { "[p", move_textobject("goto_previous_start", "@parameter.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous parameter start" },
      { "]r", move_textobject("goto_next_start", "@return.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next return start" },
      { "[r", move_textobject("goto_previous_start", "@return.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous return start" },
      { "]a", move_textobject("goto_next_start", "@attribute.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next attribute start" },
      { "[a", move_textobject("goto_previous_start", "@attribute.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous attribute start" },
      { "]x", move_textobject("goto_next_start", "@regex.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next regex start" },
      { "[x", move_textobject("goto_previous_start", "@regex.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous regex start" },
      { "]C", move_textobject("goto_next_start", "@call.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next call start" },
      { "[C", move_textobject("goto_previous_start", "@call.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous call start" },
      { "]m", move_textobject("goto_next_start", "@comment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next comment start" },
      { "[m", move_textobject("goto_previous_start", "@comment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous comment start" },
      { "]F", move_textobject("goto_next_start", "@frame.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next frame start" },
      { "[F", move_textobject("goto_previous_start", "@frame.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous frame start" },
      { "]A", move_textobject("goto_next_start", "@assignment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next assignment start" },
      { "[A", move_textobject("goto_previous_start", "@assignment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous assignment start" },
      { "]L", move_textobject("goto_next_start", "@assignment.lhs", "textobjects"), mode = { "n", "o", "x" }, desc = "next assignment lhs start" },
      { "[L", move_textobject("goto_previous_start", "@assignment.lhs", "textobjects"), mode = { "n", "o", "x" }, desc = "previous assignment lhs start" },
      { "]R", move_textobject("goto_next_start", "@assignment.rhs", "textobjects"), mode = { "n", "o", "x" }, desc = "next assignment rhs start" },
      { "[R", move_textobject("goto_previous_start", "@assignment.rhs", "textobjects"), mode = { "n", "o", "x" }, desc = "previous assignment rhs start" },
      { "]z", move_textobject("goto_next_start", "@fold", "folds"), mode = { "n", "o", "x" }, desc = "next fold start" },
      { "[z", move_textobject("goto_previous_start", "@fold", "folds"), mode = { "n", "o", "x" }, desc = "previous fold start" },
      { "]S", move_textobject("goto_next_start", "@local.scope", "locals"), mode = { "n", "o", "x" }, desc = "next local scope start" },
      { "[S", move_textobject("goto_previous_start", "@local.scope", "locals"), mode = { "n", "o", "x" }, desc = "previous local scope start" },
      { "]n", move_textobject("goto_next_start", "@number.inner", "textobjects"), mode = { "n", "o", "x" }, desc = "next number start" },
      { "[n", move_textobject("goto_previous_start", "@number.inner", "textobjects"), mode = { "n", "o", "x" }, desc = "previous number start" },

      -- ==========================================================
      -- ⚓ Move End (Jump to the end: Using { and })
      -- ==========================================================
      { "}c", move_textobject("goto_next_end", "@class.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next class end" },
      { "{c", move_textobject("goto_previous_end", "@class.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous class end" },
      { "}f", move_textobject("goto_next_end", "@function.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next function end" },
      { "{f", move_textobject("goto_previous_end", "@function.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous function end" },
      { "}b", move_textobject("goto_next_end", "@block.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next block end" },
      { "{b", move_textobject("goto_previous_end", "@block.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous block end" },
      { "}s", move_textobject("goto_next_end", "@statement.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next statement end" },
      { "{s", move_textobject("goto_previous_end", "@statement.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous statement end" },
      { "}d", move_textobject("goto_next_end", "@conditional.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next conditional end" },
      { "{d", move_textobject("goto_previous_end", "@conditional.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous conditional end" },
      { "}l", move_textobject("goto_next_end", "@loop.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next loop end" },
      { "{l", move_textobject("goto_previous_end", "@loop.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous loop end" },
      { "}p", move_textobject("goto_next_end", "@parameter.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next parameter end" },
      { "{p", move_textobject("goto_previous_end", "@parameter.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous parameter end" },
      { "}r", move_textobject("goto_next_end", "@return.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next return end" },
      { "{r", move_textobject("goto_previous_end", "@return.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous return end" },
      { "}a", move_textobject("goto_next_end", "@attribute.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next attribute end" },
      { "{a", move_textobject("goto_previous_end", "@attribute.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous attribute end" },
      { "}x", move_textobject("goto_next_end", "@regex.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next regex end" },
      { "{x", move_textobject("goto_previous_end", "@regex.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous regex end" },
      { "}C", move_textobject("goto_next_end", "@call.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next call end" },
      { "{C", move_textobject("goto_previous_end", "@call.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous call end" },
      { "}m", move_textobject("goto_next_end", "@comment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next comment end" },
      { "{m", move_textobject("goto_previous_end", "@comment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous comment end" },
      { "}F", move_textobject("goto_next_end", "@frame.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next frame end" },
      { "{F", move_textobject("goto_previous_end", "@frame.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous frame end" },
      { "}A", move_textobject("goto_next_end", "@assignment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "next assignment end" },
      { "{A", move_textobject("goto_previous_end", "@assignment.outer", "textobjects"), mode = { "n", "o", "x" }, desc = "previous assignment end" },
      { "}L", move_textobject("goto_next_end", "@assignment.lhs", "textobjects"), mode = { "n", "o", "x" }, desc = "next assignment lhs end" },
      { "{L", move_textobject("goto_previous_end", "@assignment.lhs", "textobjects"), mode = { "n", "o", "x" }, desc = "previous assignment lhs end" },
      { "}R", move_textobject("goto_next_end", "@assignment.rhs", "textobjects"), mode = { "n", "o", "x" }, desc = "next assignment rhs end" },
      { "{R", move_textobject("goto_previous_end", "@assignment.rhs", "textobjects"), mode = { "n", "o", "x" }, desc = "previous assignment rhs end" },
      { "}z", move_textobject("goto_next_end", "@fold", "folds"), mode = { "n", "o", "x" }, desc = "next fold end" },
      { "{z", move_textobject("goto_previous_end", "@fold", "folds"), mode = { "n", "o", "x" }, desc = "previous fold end" },
      { "}n", move_textobject("goto_next_end", "@number.inner", "textobjects"), mode = { "n", "o", "x" }, desc = "next number end" },
      { "{n", move_textobject("goto_previous_end", "@number.inner", "textobjects"), mode = { "n", "o", "x" }, desc = "previous number end" },

      -- ==========================================================
      -- 🔄 Repeat (Repeat the last Treesitter jump)
      -- ==========================================================
      {
        ";",
        function()
          return require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_next()
        end,
        mode = { "n", "x", "o" },
        desc = "ts repeat forward",
      },
      {
        ",",
        function()
          return require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_previous()
        end,
        mode = { "n", "x", "o" },
        desc = "ts repeat backward",
      },
    }
  end,
  opts = {
    select = {
      lookahead = true,
      include_surrounding_whitespace = true,
    },
  },
}
