local present, indent = pcall(require, "indent_blankline")
if present == nil then
  return
end

local options = {

}

--vim.g.indent_blankline_char = "￤"
indent.setup(options)

vim.cmd([[
highlight IndentBlanklineChar guifg=#666666 gui=nocombine
]])
