local default_sources = {
  'avante',
  'lsp',
  'path',
  'snippets',
  'buffer',
  'minuet',
  'codeium',
}

local spec = {
  'saghen/blink.cmp',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'xzbdmw/colorful-menu.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = 'v2.4.1',
      build = 'make install_jsregexp',
      event = 'InsertEnter',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },

    'Kaiser-Yang/blink-cmp-avante',
    'milanglacier/minuet-ai.nvim',

    {
      'saghen/blink.compat',
      dependencies = {
        'hrsh7th/cmp-nvim-lua',
      },
      version = '2.*',
      lazy = true,
      opts = {},
    },

  },
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  opts = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    vim.lsp.config('*', { capabilities = capabilities })
    local kind_icons = require('core.config.lsp').kind_icons
    return {
      keymap = {
        preset = 'default',
        ['<C-n>'] = {
          function(cmp)
            if not cmp.is_menu_visible() then
              cmp.show()
              return true
            end
          end,
          'select_next',
          'fallback',
        },
        ['<M-o>'] = {
          --- Force ai completion
          function(cmp)
            cmp.show({ providers = 'minuet' })
            cmp.show({ providers = 'codeium' })
            return true
          end,
        },
      },

      appearance = {
        nerd_font_variant = 'mono',
        kind_icons = kind_icons,
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = { border = 'double' },
        },
        list = {
          selection = {
            preselect = false,
          },
        },

        menu = {
          draw = {
            columns = {
              { 'kind_icon' },
              { 'kind' },
              { 'label' },
              { 'source_name' },
            },
            components = {
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
          },
          border = 'rounded',
          max_height = 30,
        },

        trigger = {
          prefetch_on_insert = false,
          show_on_insert = true,
          show_on_x_blocked_trigger_characters = {},
        },
      },

      signature = {
        enabled = true,
        window = { border = 'single' },
      },

      cmdline = {
        keymap = {
          preset = 'cmdline',
          ['<C-n>'] = {
            function(cmp)
              if not cmp.is_menu_visible() then
                cmp.show_and_insert_or_accept_single()
                return true
              end
            end,
            'select_next',
            'fallback',
          },
          ['<tab>'] = {
            function(cmp)
              if not cmp.is_menu_visible() then
                cmp.show_and_insert_or_accept_single()
                return true
              end
            end,
            'select_next',
            'fallback',
          },
        },
        completion = {
          menu = {
            auto_show = true,
          },
          list = {
            selection = {
              preselect = false,
            },
          },
        },
      },

      sources = {
        default = default_sources,
        per_filetype = {
          lua = {
            inherit_defaults = true,
            'nvim_lua',
          },
        },
        providers = {
          lsp = {
            name = 'LSP',
            module = 'blink.cmp.sources.lsp',
            -- If this provider returns 0 items, it will fallback to these providers.
            -- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
            fallbacks = { 'buffer' },
            opts = { tailwind_color_icon = '██' }, -- Passed to the source directly, varies by source
            --- NOTE: All of these options may be functions to get dynamic behavior
            --- See the type definitions for more information
            enabled = true,    -- Whether or not to enable the provider
            async = false,     -- Whether we should show the completions before this provider returns, without waiting for it
            timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
            transform_items = function(ctx, items)
              local item_kind = require('blink.cmp.types').CompletionItemKind
              return vim.tbl_filter(function(item)
                local col = item.cursor_column
                local char_before_cursor = string.sub(ctx.line, col, col)
                local kind = item.kind
                if char_before_cursor == '.' then
                  if
                      kind ~= item_kind.Field
                      and kind ~= item_kind.Method
                      and kind ~= item_kind.Variable
                      and kind ~= item_kind.Class
                      and kind ~= item_kind.Function
                      and kind ~= item_kind.File
                      or item.label:sub(1, 1) == '_'
                  then
                    return false
                  end
                end
                return true
              end, items)
            end,                      -- Function to transform the items before they're returned
            should_show_items = true, -- Whether or not to show the items
            max_items = nil,          -- Maximum number of items to display in the menu
            min_keyword_length = 0,   -- Minimum number of characters in the keyword to trigger the provider
            score_offset = 0,         -- Boost/penalize the score of the items
            override = nil,           -- Override the source's functions
          },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
            },
          },
          parrot = {
            module = 'parrot.completion.blink',
            name = 'parrot',
            score_offset = 20,
            opts = {
              show_hidden_files = false,
              max_items = 50,
            },
          },
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            async = true,
            timeout_ms = 3000,
            score_offset = 30, -- Gives minuet higher priority among suggestions
          },
          codeium = {
            name = 'Codeium',
            module = 'codeium.blink',
            async = true,
            timeout_ms = 3000,
            score_offset = 50, -- Gives minuet higher priority among suggestions
          },
          nvim_lua = {
            name = 'nvim_lua',
            module = 'blink.compat.source',
          },
        },

      },

      snippets = { preset = 'luasnip' },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = {
          'exact',
          'score',
          'sort_text',
          'label',
          'kind',
        },
      },
    }
  end,
}

return spec
