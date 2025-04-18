local ui = require("core.config.ui")

local icon = {
  type = "text",
  val = ui.icon_table,
  opts = {
    position = "center",
    hl = "DevIconMate",
  }
}

local date = {
  type = "text",
  val = ui.date,
  opts = {
    position = "center",

    hl = "DevIconNix"
  }
}


local top = {
  type = "button",
  val = "  🞂 New file",
  on_press = function()
    vim.api.nvim_command("enew | silent NvimTreeOpen")
  end,
  opts = {
    position = "center",
    hl = "DevIconGz",

    shortcut = "[e]",

    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "DevIconBzl",

    keymap = {
      'n',
      'e',
      ':enew | silent NvimTreeOpen<CR>',
      { noremap = true, silent = true, nowait = true }
    }
  }
}

local body = {
  type = "group",
  val = {
    {
      type = "button",
      val = "󰮗  🞂 Find files",
      on_press = function()
        vim.cmd([[Telescope find_files]])
      end,
      opts = {
        position = "center",
        hl = "DevIconGz",

        shortcut = "[f]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "DevIconBzl",

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
      val = "󰕁  🞂 Recents",
      on_press = function()
        vim.api.nvim_command("Telescope oldfiles")
      end,
      opts = {
        position = "center",
        hl = "DevIconGz",

        shortcut = "[r]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "DevIconBzl",

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
      val = "󱀾  🞂 Find word",
      on_press = function()
        if vim.fn.executable("rg") == 0 then
          vim.api.nvim_command("Telescope grep_string")
        else
          vim.api.nvim_command("Telescope live_grep")
        end
      end,
      opts = {
        position = "center",
        hl = "DevIconGz",

        shortcut = "[w]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "DevIconBzl",

        keymap = {
          'n',
          'w',
          function()
            if vim.fn.executable("rg") == 0 then
              return ':Telescope grep_string<CR>'
            else
              return ':Telescope live_grep<CR>'
            end
          end,
          { noremap = true, expr = true, silent = true, nowait = true }
        }
      }
    },
    {
      type = "button",
      val = "󰦛  🞂 Last session",
      on_press = function()
        vim.api.nvim_command("SessionRestore")
      end,
      opts = {
        position = "center",
        hl = "DevIconGz",

        shortcut = "[l]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "DevIconBzl",

        keymap = {
          'n',
          'l',
          ':SessionRestore<CR>',
          { noremap = true, silent = true, nowait = true }
        }
      }
    },
    {
      type = "button",
      val = "  🞂 Colorschemes",
      on_press = function()
        local path = vim.fn.stdpath('config') .. '/lua/plugins/colorscheme'
        for _, v in pairs(vim.fn.readdir(path)) do
          require(vim.fn.fnamemodify(v, ':r'))
        end
        vim.api.nvim_command("Telescope colorscheme")
      end,
      opts = {
        position = "center",
        hl = "DevIconGz",

        shortcut = "[c]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "DevIconBzl",

        keymap = {
          'n',
          'c',
          [[:let b:path = stdpath('config') .. '/lua/plugins/colorscheme'
            :for file in readdir(b:path) |
              exec "lua require('" . fnamemodify(file, ':r') . "')" |
            endfor
            :Telescope colorscheme<CR>]],
          { noremap = true, silent = true, nowait = true }
        }
      }
    },
    {
      type = "button",
      val = "  🞂 Quit",
      on_press = function()
        vim.api.nvim_command("qall")
      end,
      opts = {
        position = "center",
        hl = "DevIconGz",

        shortcut = "[q]",
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "DevIconBzl",

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
  val = function()
    return "  neovim loaded " .. require("lazy").stats().loaded .. " plugins"
  end,
  opts = {
    position = "center",
    hl = { { "DevIconPpt", 0, 3 }, { "DevIconSig", 3, -1 } }
  }
}

local copyright = {
  type = "text",
  val = "-- Copyright © urayoru -- ",
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
    { type = "padding", val = 1 },
    foooter,
  },
  opts = {
    --margin = 0
  }
}

local spec = {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = options,
}

return spec
