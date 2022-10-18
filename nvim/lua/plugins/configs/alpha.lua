local present, alpha = pcall(require, "alpha")

if present == nil then
  return
end

local icon_table = {
  "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
  "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
  "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
  "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

local icon = {
  type = "text",
  val = icon_table,
  opts = {
    position = "center",
    hl = "WarningMsg",
  }
}

local date = {
  type = "text",
  val = vim.fn.strftime("  Today is %a %d %b %Y, have a nice day."),
  opts = {
    position = "center",

    hl = "MoreMsg"
  }
}

local top = {
  type = "button",
  val = "  🞂 New file",
  on_press = function()
    vim.fn.execute("enew | silent NvimTreeOpen")
  end,
  opts = {
    position = "center",
    hl = "tag",

    shortcut = "[e]",
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "Type",

        keymap = {
          'n',
          'e',
          ':enew | silent! NvimTreeOpen<CR>',
          { noremap = true, silent = true, nowait = true }
        }
  }
}

local body = {
  type = "group",
  val = {
    {
      type = "button",
      val = "  🞂 Find files",
      on_press = function()
        vim.cmd([[Telescope find_files]])
      end,
      opts = {
        position = "center",
        hl = "tag",

        shortcut = "[f]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Type",

        keymap = {
          'n',
          'f',
          ':Telescope find_files<CR>',
          { noremap = true, silent = true, nowait = true }
        }

      }
    },
    {
      type = "button",
      val = "ﭯ  🞂 Recents",
      on_press = function()
        vim.fn.execute("Telescope oldfiles")
      end,
      opts = {
        position = "center",
        hl = "tag",

        shortcut = "[r]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Type",

        keymap = {
          'n',
          'r',
          ':Telescope oldfiles<CR>',
          { noremap = true, silent = true, nowait = true }
        }
      }
    },
    {
      type = "button",
      val = "  🞂 Find word",
      on_press = function()
        vim.fn.execute("Telescope live_grep")
      end,
      opts = {
        position = "center",
        hl = "tag",

        shortcut = "[w]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Type",

        keymap = {
          'n',
          'w',
          ':Telescope live_grep<CR>',
          { noremap = true, silent = true, nowait = true }
        }
      }
    },
    {
      type = "button",
      val = "  🞂 Quit",
      on_press = function()
        vim.fn.execute("qall")
      end,
      opts = {
        position = "center",
        hl = "tag",

        shortcut = "[q]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Type",

        keymap = {
          'n',
          'q',
          ':q<CR>',
          { noremap = true, silent = true, nowait = true }
        }
      },
    },
  },
  opts = {
    spacing = 1
  }
}

local foooter = {
  type = "text",
  val = "-- urayoru -- ",
  opts = {
    position = "center",
    hl = "SplashAuthor"
  }
}

local options = {
  layout = {
    { type = "padding", val = 3 },
    icon,
    { type = "padding", val = 1 },
    date,
    { type = "padding", val = 2 },
    top,
    { type = "padding", val = 1 },
    body,
    { type = "padding", val = 3 },
    foooter,
  },
  opts = {
    --margin = 0
  }
}

alpha.setup(options)
