return
{
  -- https://github.com/numToStr/Comment.nvim
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
    toggler = {
      ---Line-comment toggle keymap
      line = '<C-_>',
      ---Block-comment toggle keymap
      block = '<leader>/',
    },
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = false,
    },
  },
}
