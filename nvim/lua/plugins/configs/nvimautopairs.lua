local present, npairs = pcall(require, "nvim-autopairs")

if not present then
  return
end

local options = {
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = 's',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
}

npairs.setup(options)

local rule = require "nvim-autopairs.rule"
local cond = require('nvim-autopairs.conds')

npairs.add_rules({
  rule("%", "%", "htmldjango")
  :with_pair(cond.before_text("{"))
})
