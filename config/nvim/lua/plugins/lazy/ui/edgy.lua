return {
  --https://github.com/folke/edgy.nvim
  "folke/edgy.nvim",
  lazy = false,
  opts = {
    keys = {
      ["q"] = function(win)
        win:close()
      end,
      -- hide window
      ["<c-q>"] = false, -- win:hide()
      -- close sidebar, override by outsize keys
      ["Q"] = false,     --win.view.edgebar:close()
      -- next open window
      ["]w"] = function(win)
        win:next({ visible = true, focus = true })
      end,
      -- previous open window
      ["[w"] = function(win)
        win:prev({ visible = true, focus = true })
      end,
      -- next loaded window
      ["]W"] = function(win)
        win:next({ pinned = false, focus = true })
      end,
      -- prev loaded window
      ["[W"] = function(win)
        win:prev({ pinned = false, focus = true })
      end,
      -- increase width
      ["<c-w>>"] = function(win)
        win:resize("width", 2)
      end,
      -- decrease width
      ["<c-w><lt>"] = function(win)
        win:resize("width", -2)
      end,
      -- increase height
      ["<c-w>+"] = function(win)
        win:resize("height", 2)
      end,
      -- decrease height
      ["<c-w>-"] = function(win)
        win:resize("height", -2)
      end,
      -- reset all custom sizing
      ["<c-w>="] = function(win)
        win.view.edgebar:equalize()
      end,
    },
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = "Neo-Tree",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        size = { height = 0.5 },
      },
    },
    right = {
      {
        -- codecompanion at the right
        title = function()
          local winid = vim.g.statusline_winid
          if not winid then return "Codecompanion" end
          local bufnr = vim.api.nvim_win_get_buf(winid)
          local chat = require("codecompanion").buf_get_chat(bufnr)
          if not chat then return "Codecompanion" end
          local adapter = chat.adapter
          local provider = adapter.formatted_name or adapter.name or ""
          local model = (adapter.model and adapter.model.formatted_name)
              or (adapter.schema and adapter.schema.model and adapter.schema.model.default)
              or ""
          if provider == "" and model == "" then
            return "Codecompanion"
          elseif provider ~= nil and model == "" then
            return provider
          else
            return provider .. " / " .. model
          end
        end,
        ft = "codecompanion",
        size = {
          width = 0.5,
        },
      },
    },
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = "dap-view",
        size = { height = 0.3 },
      },
    },
    animate = {
      enabled = false,
    },
  },
}
