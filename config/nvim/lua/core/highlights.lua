local M = {
  general = {
    { 0, 'SplashAuthor', { fg = '#6d8086' } },
    { 0, 'Pmenu', { fg = 'none', bg = 'none' } },
    { 0, 'LineNrAbove', { fg = '#00ffff' } },
    { 0, 'LineNrBelow', { fg = '#ff0000' } },
    { 0, 'LineNr', { fg = '#ffff00' } },
    { 0, 'CmpItemKindCopilot', { fg = '#6CC644' } },
  },
  aerial = {
    { 0, 'AerialClass', { link = 'Type' } },
    { 0, 'AerialClassIcon', { link = 'Special' } },
    { 0, 'AerialFunction', { link = 'Special' } },
    { 0, 'AerialFunctionIcon', { fg = '#cb4b16', bg = 'none' } },
    { 0, 'AerialNormal', { link = 'Normal' } },
    { 0, 'AerialLine', { link = 'QuickFixLine' } },
    { 0, 'AerialLineNC', { bg = 'Gray' } },
    { 0, 'AerialGuide', { link = 'Comment' } },
    { 0, 'AerialGuide1', { fg = 'Red' } },
    { 0, 'AerialGuide2', { fg = 'Blue' } },
  },
}
return M
