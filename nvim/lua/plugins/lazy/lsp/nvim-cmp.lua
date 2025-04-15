-- copy from https://github.com/onsails/lspkind.nvim/blob/master/lua/lspkind/init.lua
local kind_presets = {
  default = {
    -- if you change or add symbol here
    -- replace corresponding line in readme
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
  },
  codicons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
}
-- end copy

local kind_icons = {
  TabNine = "",
  Copilot = "",
}

local options = function()
  local cmp = require("cmp")
  local item_kind = require("cmp.types").lsp.CompletionItemKind
  local kind_menus = {
    nvim_lsp = "[LSP]",
    luasnip = "[Snippet]",
    buffer = "[Buf]",
    path = "[Path]",
    cmp_tabnine = "[TN]",
    copilot = "[Co]",
    cmdline = "[CMD]",
    dap = "[DAP]",
    nvim_lsp_signature_help = "[SIG]",
    tmux = "[TMUX]"
  }
  return {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = {
      {
        name = "nvim_lsp",
        entry_filter = function(entry, context)
          local kind = entry:get_kind()

          local line = context.cursor_line
          local col = context.cursor.col
          local char_before_cursor = string.sub(line, col, col)

          if char_before_cursor == "." then
            if
                kind ~= item_kind.Field
                and kind ~= item_kind.Method
                and kind ~= item_kind.Variable
                and kind ~= item_kind.Class
                and kind ~= item_kind.Function
                or entry:get_vim_item(0).abbr:sub(1, 1) == "_"
            then
              return false
            end
          elseif string.match(line, "^%s*%w*$") then
            --if kind ~= item_kind.Function and kind ~= item_kind.Variable then
            --	return false
            --end
          end
          return true
        end,
      },
      --{ name = "cmp_tabnine" },
      { name = "buffer" },
      { name = "path" },
      { name = "copilot" },
      { name = "dap" },
      { name = 'nvim_lsp_signature_help' }
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = (kind_presets.default[vim_item.kind] or kind_icons[vim_item.kind] or "")
            .. " "
            .. vim_item.kind
            .. ":"
        vim_item.menu = kind_menus[entry.source.name] or entry.source.name
        if entry.source.name == "cmp_tabnine" then
          local detail = (entry.completion_item.labelDetails or {}).detail
          if detail and detail:find(".*%%.*") then
            vim_item.menu = vim_item.menu .. " " .. detail
          end
        end
        return vim_item
      end,
    },
    window = {
      documentation = {
        border = "double",
      },
      completion = {
        border = { "◯", "─", "◯", "│", "◯", "─", "◯", "│" },
      },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,
        require("cmp_tabnine.compare"),
        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
      ['<S-CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<C-e>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.abort()
        else
          fallback()
        end
      end, { 'i' }),
      ["<C-n>"] = cmp.mapping(
        function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end),
      ["<C-p>"] = cmp.mapping(
        function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end)
    })
  }
end

local ft_options = {
  lua = {
    sources = {
      { name = "luasnip" },
      { name = "nvim_lua" },
    },
  },
}

local spec = {
  "hrsh7th/nvim-cmp",

  dependencies = {
    "neovim/nvim-lspconfig",

    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "rcarriga/cmp-dap",

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",


    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",

    {
      "tzachar/cmp-tabnine",
      build = "./install.sh",
    },
    {
      dependencies = "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
    },
  },
  opts = options,
  config = function(_, opts)
    local cmp = require("cmp")
    local utils = require("core.utils")

    cmp.setup(opts)

    for ft, ft_opts in pairs(ft_options) do
      cmp.setup.filetype(ft, utils.tbl_deep_merge(true, ft_opts, opts))
    end

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })

    local tabnine = require("cmp_tabnine.config")
    tabnine:setup({
      max_num_results = 0,
      show_prediction_strength = true,
    })

    local copilot = require("copilot")
    copilot.setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
      }
    })

    local copilot_cmp = require("copilot_cmp")
    copilot_cmp.setup({
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = true,
    })
  end,
}

return spec
