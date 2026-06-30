local M = {
  general = {
    { 0, "SplashAuthor", { fg = "#6d8086" } },
    { 0, "Pmenu", { fg = "none", bg = "none" } },
    { 0, "LineNrAbove", { fg = "#00ffff" } },
    { 0, "LineNrBelow", { fg = "#ff0000" } },
    { 0, "LineNr", { fg = "#ffff00" } },
    { 0, "CmpItemKindCopilot", { fg = "#6CC644" } },
    -- Standard ROYGBIV Rainbow Labels (High contrast & vibrant!)
    { 0, "RainbowRed", { fg = "#e81416", bg = "#1E1E2E", bold = true } },
    { 0, "RainbowOrange", { fg = "#ffa500", bg = "#1E1E2E", bold = true } },
    { 0, "RainbowYellow", { fg = "#faeb36", bg = "#1E1E2E", bold = true } },
    { 0, "RainbowGreen", { fg = "#79c314", bg = "#1E1E2E", bold = true } },
    { 0, "RainbowBlue", { fg = "#487de7", bg = "#1E1E2E", bold = true } },
    { 0, "RainbowIndigo", { fg = "#4b369d", bg = "#1E1E2E", bold = true } },
    { 0, "RainbowViolet", { fg = "#70369d", bg = "#1E1E2E", bold = true } },
  },
  aerial = {
    { 0, "AerialClass", { link = "Type" } },
    { 0, "AerialClassIcon", { link = "Special" } },
    { 0, "AerialFunction", { link = "Special" } },
    { 0, "AerialFunctionIcon", { fg = "#cb4b16", bg = "none" } },
    { 0, "AerialNormal", { link = "Normal" } },
    { 0, "AerialLine", { link = "QuickFixLine" } },
    { 0, "AerialLineNC", { bg = "Gray" } },
    { 0, "AerialGuide", { link = "Comment" } },
    { 0, "AerialGuide1", { fg = "Red" } },
    { 0, "AerialGuide2", { fg = "Blue" } },
  },
}
return M
