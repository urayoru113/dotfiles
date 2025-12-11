local options = function()
  local dashboard = require("alpha.themes.dashboard")
  local ui = require("core.config.ui")

  -- Header
  dashboard.section.header.val = ui.icon_table
  dashboard.section.header.opts.hl = "DevIconMate"

  -- Date
  local date_section = {
    type = "text",
    val = ui.date,
    opts = {
      position = "center",
      hl = "DevIconNix",
    },
  }

  -- Buttons
  dashboard.section.buttons.val = {
    dashboard.button("e", "   New file", ":enew | silent NvimTreeOpen<CR>"),
    dashboard.button("f", "󰮗   Find files", ":Telescope find_files<CR>"),
    dashboard.button("r", "󰕁   Recents", ":Telescope oldfiles<CR>"),
    dashboard.button("w", "󱀾   Find word", function()
      if vim.fn.executable("rg") == 1 then
        vim.cmd("Telescope live_grep")
      else
        vim.cmd("Telescope grep_string")
      end
    end),
    dashboard.button("b", "󱓍   Git branches", ":Telescope git_branches<CR>"),
    dashboard.button("l", "󰦛   Last session", ":AutoSession restore<CR>"),
    dashboard.button("z", "󱁤   Lazy plugins", ":Lazy<CR>"),
    dashboard.button("c", "   Colorschemes", ":Telescope colorscheme enable_preview=true<CR>"),
    dashboard.button("q", "   Quit", ":qa<CR>"),
  }

  -- Customize button styling
  for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "DevIconGz"
    button.opts.hl_shortcut = "DevIconBzl"
    button.opts.width = 50
    button.opts.align_shortcut = "right"
  end

  -- Footer
  dashboard.section.footer.val = function()
    return "  neovim loaded " .. require("lazy").stats().loaded .. " plugins"
  end
  dashboard.section.footer.opts.hl = { { "DevIconPpt", 0, 3 }, { "DevIconSig", 3, -1 } }

  -- Copyright
  local copyright = {
    type = "text",
    val = "-- Copyright © urayoru -- ",
    opts = {
      position = "center",
      hl = "SplashAuthor",
    },
  }

  -- Layout
  dashboard.config.layout = {
    { type = "padding", val = 3 },
    dashboard.section.header,
    { type = "padding", val = 1 },
    date_section,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
    { type = "padding", val = 1 },
    copyright,
  }
  return dashboard.config
end

local spec = {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = options,
}

return spec
