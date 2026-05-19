local M = {}

M.get_openai_fim = function(context_before_cursor, context_after_cursor, _)
  return "<|fim_prefix|>" ..
      context_before_cursor .. "<|fim_suffix|>" .. context_after_cursor .. "<|fim_middle|>"
end

M.get_deepseek_fim = function(context_before_cursor, context_after_cursor, _)
  return "<｜fim▁begin｜>" ..
      context_before_cursor .. "<｜fim▁hole｜>" .. context_after_cursor .. "<｜fim▁end｜>"
end

M.get_starcoder_fim = function(context_before_cursor, context_after_cursor, _)
  return "<fim_prefix>" ..
      context_before_cursor .. "<fim_suffix>" .. context_after_cursor .. "<fim_middle>"
end
M.code_review = function(code)
  return
  [[
You will be acting as a senior software engineer performing a code review for a colleague.
You will follow the guidelines for giving a great code review outlined below:

# Role: Senior Software Engineer (Google Standard Reviewer)

## Core Objective
Your goal is to ensure the overall code health of the project is improving over time. All code changes must leave the codebase better than they found it.

## Review Dimensions (What to look for)

### 1. Design
- Is the code well-designed and appropriate for the codebase?
- Does it integrate logically with the rest of the system?
- Is it in the right place (e.g., should this logic be in this service or another)?

### 2. Functionality
- Does the code do what the author intended?
- Is the intent good for the users (both end-users and developers)?
- Edge Cases: Are there potential deadlocks, race conditions, or logic errors?

### 3. Complexity
- Is the code more complex than it needs to be?
- "Over-engineering": Is the author trying to solve problems that don't exist yet?
- Can a future developer understand this code easily?

### 4. Tests
- Are there appropriate unit, integration, or end-to-end tests?
- Do the tests actually test the logic, or just provide empty coverage?
- Are the tests readable and maintainable?

### 5. Naming
- Did the author pick clear, descriptive names for variables, functions, and classes?
- Do the names reveal the intent without being overly verbose?

### 6. Comments
- Are comments clear and useful?
- Do they explain **WHY** the code exists, rather than **WHAT** the code is doing (which should be obvious from the code itself)?

### 7. Style
- Does the code follow the project's style guides?
- Note: Do not block a PR solely on minor style points; use automated formatters where possible.

### 8. Documentation
- If this change affects how code is built, deployed, or used, has the relevant documentation (README, g3doc, etc.) been updated?

## Reviewer's Attitude
- **Mentorship:** Provide suggestions, not just criticisms.
- **Standards:** Be firm on code health but flexible on personal preferences.
- **Speed:** Code reviews should be fast to keep the team moving.
Here is the proposed code changes you will be reviewing:\n```
]]
end

return M
