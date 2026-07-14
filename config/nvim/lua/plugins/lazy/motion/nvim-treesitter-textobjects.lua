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
        if func then
          func(query, group)
        end
      end
    end

    local keys = {}

    -- ==========================================================
    -- 🎯 1. Select Textobjects Configuration
    -- ==========================================================
    local select_configs = {
      { key = "c", query = "@class", desc = "class" },
      { key = "f", query = "@function", desc = "function" },
      { key = "b", query = "@block", desc = "block" },
      { key = "s", query = "@statement", desc = "statement", no_inner = true },
      { key = "d", query = "@conditional", desc = "conditional logic" },
      { key = "l", query = "@loop", desc = "loop" },
      { key = "p", query = "@parameter", desc = "parameter" },
      { key = "r", query = "@return", desc = "return" },
      { key = "a", query = "@attribute", desc = "attribute" },
      { key = "x", query = "@regex", desc = "regex pattern" },
      { key = "C", query = "@call", desc = "function call" },
      { key = "m", query = "@comment", desc = "comment" },
      { key = "F", query = "@frame", desc = "frame" },
      { key = "A", query = "@assignment", desc = "assignment" },
      { key = "L", exact = true, query = "@assignment.lhs", desc = "assignment lhs" },
      { key = "R", exact = true, query = "@assignment.rhs", desc = "assignment rhs" },
      { key = "n", query = "@number", desc = "number", no_outer = true },
      { key = "S", query = "@scopename", desc = "scope name", no_outer = true },
    }

    for _, def in ipairs(select_configs) do
      if def.exact then
        table.insert(
          keys,
          { def.key, select_textobject(def.query, "textobjects"), mode = { "o", "x" }, desc = def.desc }
        )
      else
        if not def.no_outer then
          table.insert(keys, {
            "a" .. def.key,
            select_textobject(def.query .. ".outer", "textobjects"),
            mode = { "o", "x" },
            desc = "around " .. def.desc,
          })
        end
        if not def.no_inner then
          table.insert(keys, {
            "i" .. def.key,
            select_textobject(def.query .. ".inner", "textobjects"),
            mode = { "o", "x" },
            desc = "inner " .. def.desc,
          })
        end
      end
    end

    -- ==========================================================
    -- 🚀 2. Move Textobjects Configuration
    -- ==========================================================
    local move_configs = {
      { key = "c", query = "@class.outer", desc = "class" },
      { key = "f", query = "@function.outer", desc = "function" },
      { key = "b", query = "@block.outer", desc = "block" },
      { key = "s", query = "@statement.outer", desc = "statement" },
      { key = "d", query = "@conditional.outer", desc = "conditional" },
      { key = "l", query = "@loop.outer", desc = "loop" },
      { key = "p", query = "@parameter.outer", desc = "parameter" },
      { key = "r", query = "@return.outer", desc = "return" },
      { key = "a", query = "@attribute.outer", desc = "attribute" },
      { key = "x", query = "@regex.outer", desc = "regex" },
      { key = "C", query = "@call.outer", desc = "call" },
      { key = "m", query = "@comment.outer", desc = "comment" },
      { key = "F", query = "@frame.outer", desc = "frame" },
      { key = "A", query = "@assignment.outer", desc = "assignment" },
      { key = "L", query = "@assignment.lhs", desc = "assignment lhs" },
      { key = "R", query = "@assignment.rhs", desc = "assignment rhs" },
      { key = "n", query = "@number.inner", desc = "number" },
      { key = "z", query = "@fold", desc = "fold", group = "folds" },
      { key = "S", query = "@local.scope", desc = "local scope", group = "locals" },
    }

    local move_directions = {
      { prefix = "]", func = "goto_next_start", desc = "next %s start" },
      { prefix = "[", func = "goto_previous_start", desc = "prev %s start" },
      { prefix = "}", func = "goto_next_end", desc = "next %s end" },
      { prefix = "{", func = "goto_previous_end", desc = "prev %s end" },
    }

    for _, def in ipairs(move_configs) do
      local group = def.group or "textobjects"
      for _, dir in ipairs(move_directions) do
        table.insert(keys, {
          dir.prefix .. def.key,
          move_textobject(dir.func, def.query, group),
          mode = { "n", "o", "x" },
          desc = string.format(dir.desc, def.desc),
        })
      end
    end

    -- ==========================================================
    -- ⚓ 3. Vim Native Fallbacks & Repeat
    -- ==========================================================
    -- Maintain native paragraph jumping mapped to double braces
    table.insert(keys, { "}}", "}", mode = { "n", "x", "o" }, desc = "next paragraph (native)" })
    table.insert(keys, { "{{", "{", mode = { "n", "x", "o" }, desc = "previous paragraph (native)" })

    -- Repeat last move
    table.insert(keys, {
      ";",
      function()
        return require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_next()
      end,
      mode = { "n", "x", "o" },
      desc = "ts repeat forward",
    })
    table.insert(keys, {
      ",",
      function()
        return require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_previous()
      end,
      mode = { "n", "x", "o" },
      desc = "ts repeat backward",
    })

    return keys
  end,
  --- @type TSTextObjects.Config
  opts = {
    select = {
      lookahead = true,
      include_surrounding_whitespace = false,
    },
  },
}
