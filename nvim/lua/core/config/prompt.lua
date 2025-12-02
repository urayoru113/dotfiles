local M = {}

M.get_openai_fim = function(context_before_cursor, context_after_cursor, _)
  return '<|fim_prefix|>' ..
      context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
end

M.get_deepseek_fim = function(context_before_cursor, context_after_cursor, _)
  return '<｜fim▁begin｜>' ..
      context_before_cursor .. '<｜fim▁hole｜>' .. context_after_cursor .. '<｜fim▁end｜>'
end

return M
