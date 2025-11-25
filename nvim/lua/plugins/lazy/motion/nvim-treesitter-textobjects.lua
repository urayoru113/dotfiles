return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = 'nvim-treesitter',
  branch = 'main',
  keys = function()
    local select = require('nvim-treesitter-textobjects.select')
    local move = require('nvim-treesitter-textobjects.move')
    local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
    local function select_textobject(query, group)
      return function()
        select.select_textobject(query, group)
      end
    end
    local move_textobject = function(func_name, query, group)
      return function()
        local func = move[func_name]
        func(query, group)
      end
    end

    return {
      -- select
      { 'ic', select_textobject('@class.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner class body' },
      { 'ac', select_textobject('@class.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around class definition' },
      { 'if', select_textobject('@function.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner function body' },
      { 'af', select_textobject('@function.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around function definition' },
      { 'ib', select_textobject('@block.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner block body' },
      { 'ab', select_textobject('@block.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around block/scope' },
      { 'as', select_textobject('@statement.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around statement' },
      { 'id', select_textobject('@conditional.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner conditional logic' },
      { 'ad', select_textobject('@conditional.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around conditional (if/else)' },
      { 'il', select_textobject('@loop.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner loop body' },
      { 'al', select_textobject('@loop.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around loop (for/while)' },
      { 'ip', select_textobject('@parameter.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner parameters/args' },
      { 'ap', select_textobject('@parameter.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around parameter list' },
      { 'ir', select_textobject('@return.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner return value' },
      { 'ar', select_textobject('@return.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around return statement' },
      { 'ia', select_textobject('@attribute.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner attribute value' },
      { 'aa', select_textobject('@attribute.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around attribute/annotation' },
      { 'iR', select_textobject('@regex.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner regex pattern' },
      { 'aR', select_textobject('@regex.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around regex pattern' },
      { 'iC', select_textobject('@call.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner function call arguments' },
      { 'aC', select_textobject('@call.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around function call' },
      { 'im', select_textobject('@comment.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner comment content' },
      { 'am', select_textobject('@comment.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around comment block' },
      { 'iF', select_textobject('@frame.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner frame body' },
      { 'aF', select_textobject('@frame.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around frame definition' },
      { 'iA', select_textobject('@assignment.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner assignment expression' },
      { 'aA', select_textobject('@assignment.outer', 'textobjects'), mode = { 'o', 'x' }, desc = 'around assignment' },
      { 'iL', select_textobject('@assignment.lhs', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner assignment lhs' },
      { 'iq', select_textobject('@assignment.rhs', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner assignment rhs' },
      { 'in', select_textobject('@number.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner number' },
      { 'iS', select_textobject('@scopename.inner', 'textobjects'), mode = { 'o', 'x' }, desc = 'inner scope name' },

      { '[c[', move_textobject('goto_previous_start', '@class.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous class start' },
      { ']c[', move_textobject('goto_next_start', '@class.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next class start' },
      { '[c]', move_textobject('goto_previous_end', '@class.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous class end' },
      { ']c]', move_textobject('goto_next_end', '@class.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next class end' },
      { '[f[', move_textobject('goto_previous_start', '@function.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous function start' },
      { ']f[', move_textobject('goto_next_start', '@function.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next function start' },
      { '[f]', move_textobject('goto_previous_end', '@function.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous function end' },
      { ']f]', move_textobject('goto_next_end', '@function.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next function end' },
      { '[b[', move_textobject('goto_previous_start', '@block.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous block start' },
      { ']b[', move_textobject('goto_next_start', '@block.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next block start' },
      { '[b]', move_textobject('goto_previous_end', '@block.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous block end' },
      { ']b]', move_textobject('goto_next_end', '@block.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next block end' },
      { '[s[', move_textobject('goto_previous_start', '@statement.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous statement start' },
      { ']s[', move_textobject('goto_next_start', '@statement.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next statement start' },
      { '[s]', move_textobject('goto_previous_end', '@statement.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous statement end' },
      { ']s]', move_textobject('goto_next_end', '@statement.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next statement end' },
      { '[d[', move_textobject('goto_previous_start', '@conditional.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous conditional start' },
      { ']d[', move_textobject('goto_next_start', '@conditional.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next conditional start' },
      { '[d]', move_textobject('goto_previous_end', '@conditional.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous conditional end' },
      { ']d]', move_textobject('goto_next_end', '@conditional.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next conditional end' },
      { '[l[', move_textobject('goto_previous_start', '@loop.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous loop start' },
      { ']l[', move_textobject('goto_next_start', '@loop.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next loop start' },
      { '[l]', move_textobject('goto_previous_end', '@loop.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous loop end' },
      { ']l]', move_textobject('goto_next_end', '@loop.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next loop end' },
      { '[p[', move_textobject('goto_previous_start', '@parameter.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous parameter list start' },
      { ']p[', move_textobject('goto_next_start', '@parameter.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next parameter list start' },
      { '[p]', move_textobject('goto_previous_end', '@parameter.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous parameter list end' },
      { ']p]', move_textobject('goto_next_end', '@parameter.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next parameter list end' },
      { '[r[', move_textobject('goto_previous_start', '@return.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous return start' },
      { ']r[', move_textobject('goto_next_start', '@return.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next return start' },
      { '[r]', move_textobject('goto_previous_end', '@return.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous return end' },
      { ']r]', move_textobject('goto_next_end', '@return.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next return end' }, { '[a[', move_textobject('goto_previous_start', '@attribute.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous attribute start' },
      { '[a[', move_textobject('goto_previous_start', '@attribute.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous attribute start' },
      { ']a[', move_textobject('goto_next_start', '@attribute.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next attribute start' },
      { '[a]', move_textobject('goto_previous_end', '@attribute.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous attribute end' },
      { ']a]', move_textobject('goto_next_end', '@attribute.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next attribute end' },
      { '[R[', move_textobject('goto_previous_start', '@regex.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous regex start' },
      { ']R[', move_textobject('goto_next_start', '@regex.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next regex start' },
      { '[R]', move_textobject('goto_previous_end', '@regex.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous regex end' },
      { ']R]', move_textobject('goto_next_end', '@regex.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next regex end' },
      { '[C[', move_textobject('goto_previous_start', '@call.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous call start' },
      { ']C[', move_textobject('goto_next_start', '@call.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next call start' },
      { '[C]', move_textobject('goto_previous_end', '@call.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous call end' },
      { ']C]', move_textobject('goto_next_end', '@call.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next call end' },
      { '[m[', move_textobject('goto_previous_start', '@comment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous comment start' },
      { ']m[', move_textobject('goto_next_start', '@comment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next comment start' },
      { '[m]', move_textobject('goto_previous_end', '@comment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous comment end' },
      { ']m]', move_textobject('goto_next_end', '@comment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next comment end' },
      { '[F[', move_textobject('goto_previous_start', '@frame.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous frame start' },
      { ']F[', move_textobject('goto_next_start', '@frame.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next frame start' },
      { '[F]', move_textobject('goto_previous_end', '@frame.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous frame end' },
      { ']F]', move_textobject('goto_next_end', '@frame.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next frame end' },
      { '[A[', move_textobject('goto_previous_start', '@assignment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous assignment start' },
      { ']A[', move_textobject('goto_next_start', '@assignment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next assignment start' },
      { '[A]', move_textobject('goto_previous_end', '@assignment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'previous assignment end' },
      { ']A]', move_textobject('goto_next_end', '@assignment.outer', 'textobjects'), mode = { 'n', 'o', 'x' }, desc = 'next assignment end' },
      { '[z[', move_textobject('goto_previous_start', '@fold', 'folds'), mode = { 'n', 'o', 'x' }, desc = 'previous fold start' },
      { ']z[', move_textobject('goto_next_start', '@fold', 'folds'), mode = { 'n', 'o', 'x' }, desc = 'next fold start' },
      { '[z]', move_textobject('goto_previous_end', '@fold', 'folds'), mode = { 'n', 'o', 'x' }, desc = 'previous fold end' },
      { ']z]', move_textobject('goto_next_end', '@fold', 'folds'), mode = { 'n', 'o', 'x' }, desc = 'next fold end' },
      { ']s', move_textobject('goto_next_start', '@local.scope', 'locals'), mode = { 'n', 'o', 'x' }, desc = 'next local scope start' },
      { ']o', function() move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects') end, mode = { 'n', 'o', 'x' }, desc = 'next loop start (fallback)' },

      { ';', ts_repeat_move.repeat_last_move_next, mode = { 'n', 'x', 'o' }, desc = 'ts repeat forward' },
      { ',', ts_repeat_move.repeat_last_move_previous, mode = { 'n', 'x', 'o' }, desc = 'ts repeat backward' },
      { 'f', ts_repeat_move.builtin_f_expr, mode = { 'n', 'x', 'o' }, expr = true, desc = 'ts next char' },
      { 'F', ts_repeat_move.builtin_F_expr, mode = { 'n', 'x', 'o' }, expr = true, desc = 'ts previous char' },
      { 't', ts_repeat_move.builtin_t_expr, mode = { 'n', 'x', 'o' }, expr = true, desc = 'ts to next char' },
      { 'T', ts_repeat_move.builtin_T_expr, mode = { 'n', 'x', 'o' }, expr = true, desc = 'ts to previous char' }
    }
  end,
  opts = {
    select = {
      lookahead = true,
      include_surrounding_whitespace = true
    }
  }
}
