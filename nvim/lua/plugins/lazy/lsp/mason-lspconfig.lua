local utils = require("core.utils")

local providers = {
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        completion = {
          enable = false,
          callSnippet = "both",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VINRUNTIME,
          },
        },
        telemetry = {
          enable = false,
        },
        hint = {
          enable = true,
        },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          disableOrganizeImports = true,
          diagnosticMode = "workspace",
        },
        pythonPath = utils.get_project_python_path(),
        venvPath = utils.get_project_venv_path("python"),
      },
    },
  },
  docker_compose_language_service = {
    settings = {},
  },
  dockerls = {
    settings = {},
  },
  ruff = {
    on_attach = function(client)
      client.server_capabilities.hoverProvider = false
    end,
    init_options = {
      settings = {
        --configuration = vim.fn.expand("%:p:h") .. "pyproject.toml",
        configurationPreference = "filesystemFirst",
        lineLength = 120,
        lint = {
          extendSelect = {
            -- https://docs.astral.sh/ruff/rules/
            "ASYNC", -- flake8-async
            "B",     -- flake8-bugbear
            "C4",    -- flake8-comprehensions
            "C90",   -- mccabe
            "COM",   -- flake8-commas
            "D",     -- pydocstyle
            "DTZ",   -- flake8-datetimez
            "E",     -- pycodestyle Error
            "F",     -- pyflakes
            "FLY",   -- flynt
            "G",     -- flake8-logging-format
            "I",     -- isort
            "ISC",   -- flake8-implicit-str-concat
            "PIE",   -- flake8-pie
            "PLC",   -- Pylint Convention
            "PLE",   -- Pylint Error
            "PLW",   -- Pylint Warning
            "RET",   -- flake8-return
            "RUF",   -- Ruff-specific rules
            "RSE",   -- flake8-raise
            "SIM",   -- flake8-simplify
            "TID",   -- flake8-tidy-imports
            "UP",    -- pyupgrade
            "W",     -- pycodestyle Warning
            "YTT",   -- flake8-2020
          },
          ignore = {
            "E741", -- Ambiguous variable name isn't a huge problem
            "B008", -- Do not perform function calls in argument defaults
            "B011", -- Allow `assert false`. We don't use `python -O`
            "B028", -- We don't need explicit `stacklevel` for warnings
            "D100", -- Docstring stuff
            "D101",
            "D102",
            "D104",
            "D105",
            "D107",
            "D203",
            "D213",
            "D401",
            "D402",
            "DTZ005", -- Allow `datetime.datetime.now()` to be called without a `tz` argument
            "E402",   -- Simplified black ignore config to make VSCode happy
            "E501",
            "E701",
            "E731",
            "C408",
            "E203",
            "G004",    -- Ignore `Logging statement uses f-string` warning
            "RET505",  -- Allow unnecessary `elif` after `return` statement
            "D106",    -- Allow undocumented public nested class
            "D205",    -- No blank line required after summary
            "PLW2901", -- Allow overwriting variables in loops ,
          },
          unfixable = {
            "F401",
            "F841", -- Unused local variable
            "F601", -- Dictionary key literal repeated
            "F602", -- Dictionary key repeated
            "B018", -- Useless expression
          }
        },
      },
    },
  },
  ts_ls = {
    init_options = {
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
    }
  },
  biome = {},
  taplo = {},
  html = {},
  clangd = {},
  bashls = {},
}

local options = function()
  local handlers = {}
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")

  for k, v in pairs(providers) do
    v = vim.tbl_deep_extend("error", v, { capabilities = capabilities })
    handlers[k] = function()
      lspconfig[k].setup(v)
    end
  end
  return {
    handlers = handlers,
  }
end

local spec = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = options,
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
    vim.api.nvim_command("LspStart")
  end,
}

return spec
