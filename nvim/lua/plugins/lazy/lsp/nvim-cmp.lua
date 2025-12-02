local lsp = require('core.config.lsp')

local options = function()
  local cmp = require('cmp')
  local item_kind = require('cmp.types').lsp.CompletionItemKind

  return {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      {
        name = 'nvim_lsp',
        entry_filter = function(entry, context)
          local kind = entry:get_kind()

          local line = context.cursor_line
          local col = context.cursor.col
          local char_before_cursor = string.sub(line, col, col)

          if char_before_cursor == '.' then
            if
                kind ~= item_kind.Field
                and kind ~= item_kind.Method
                and kind ~= item_kind.Variable
                and kind ~= item_kind.Class
                and kind ~= item_kind.Function
                or entry:get_vim_item(0).abbr:sub(1, 1) == '_'
            then
              return false
            end
          elseif string.match(line, '^%s*%w*$') then
            --if kind ~= item_kind.Function and kind ~= item_kind.Variable then
            --	return false
            --end
          end
          return true
        end,
      },
      { name = 'parrot' },
      { name = 'codecompanion' },
      { name = 'copilot' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'dap' },
      { name = 'nvim_lsp_signature_help' },
    }),
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        vim_item.kind = (lsp.kind_presets.default[vim_item.kind] or lsp.kind_icons[vim_item.kind] or '')
            .. ' '
            .. vim_item.kind
            .. ':'
        vim_item.menu = lsp.kind_menus[entry.source.name] or entry.source.name
        return vim_item
      end,
    },
    window = {
      documentation = {
        border = 'double',
      },
      completion = {
        border = { '◯', '─', '◯', '│', '◯', '─', '◯', '│' },
      },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require('copilot_cmp.comparators').prioritize,
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
      ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
      ['<S-CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<C-e>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.abort()
        else
          fallback()
        end
      end, { 'i' }),
      ['<C-n>'] = cmp.mapping(
        function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end),
      ['<C-p>'] = cmp.mapping(
        function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end),
    }),
  }
end

local ft_options = {
  lua = {
    sources = {
      { name = 'luasnip' },
      { name = 'nvim_lua' },
    },
  },
}

local spec = {
  cond = false,
  'hrsh7th/nvim-cmp',
  tag = 'v0.0.*',
  dependencies = {
    'neovim/nvim-lspconfig',

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'rcarriga/cmp-dap',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
    },
    'saadparwaiz1/cmp_luasnip',
    {
      'zbirenbaum/copilot-cmp',
      dependencies = 'zbirenbaum/copilot.lua',
      config = function()
        local copilot = require('copilot')
        copilot.setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
          },
        })

        local copilot_cmp = require('copilot_cmp')
        copilot_cmp.setup({
          event = { 'InsertEnter', 'LspAttach' },
          fix_pairs = true,
        })
      end,
    },
    'frankroeder/parrot.nvim',
  },
  opts = options,
  config = function(_, opts)
    local cmp = require('cmp')
    local utils = require('core.utils')

    cmp.setup(opts)

    for ft, ft_opts in pairs(ft_options) do
      cmp.setup.filetype(ft, utils.tbl_deep_merge(true, ft_opts, opts))
    end

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })

    cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
      sources = {
        { name = 'dap' },
      },
    })
  end,
}

return spec
