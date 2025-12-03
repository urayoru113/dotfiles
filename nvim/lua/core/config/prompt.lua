local M = {}

M.get_openai_fim = function(context_before_cursor, context_after_cursor, _)
  return '<|fim_prefix|>' ..
      context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
end

M.get_deepseek_fim = function(context_before_cursor, context_after_cursor, _)
  return '<｜fim▁begin｜>' ..
      context_before_cursor .. '<｜fim▁hole｜>' .. context_after_cursor .. '<｜fim▁end｜>'
end

M.code_review = function(code)
  return
  [[
## Role

You're a senior software engineer conducting a thorough code review. Provide constructive, actionable feedback.

## Review Areas

Analyze the selected code for:

1. **Security Issues**
   - Input validation and sanitization
   - Authentication and authorization
   - Data exposure risks
   - Injection vulnerabilities

2. **Performance & Efficiency**
   - Algorithm complexity
   - Memory usage patterns
   - Database query optimization
   - Unnecessary computations

3. **Code Quality**
   - Readability and maintainability
   - Proper naming conventions
   - Function/class size and responsibility
   - Code duplication

4. **Architecture & Design**
   - Design pattern usage
   - Separation o in current bufferf concerns
   - Dependency managemen in current buffert
   - Error handling strategy

5. **Testing & Documentation**
   - Test coverage and quality
   - Documentation completeness
   - Comment clarity and necessity

## Output Format

Provide feedback as:

**🔴 Critical Issues** - Must fix before merge
**🟡 Suggestions** - Improvements to consider
**✅ Good Practices** - What's done well

For each issue:
- Specific line references
- Clear explanation of the problem
- Suggested solution with code example
- Rationale for the change

Be constructive and educational in your feedback.
]]
end

return M
