local plugins = function(use)
  use {
    "wbthomason/packer.nvim",
    --cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  }
  use {
    "neoclide/coc.nvim",
    branch = "release",
    setup = function()
      require("core.utils").load_mappings("cocnvim")
    end
  }
  use {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require "plugins.configs.nvimtree"
    end,
    setup = function()
      require("core.utils").load_mappings("nvimtree")
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require "plugins.configs.nvimautopairs"
    end,
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "plugins.configs.treesitter"
    end,
  }
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("plugins.configs.alpha")
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require("plugins.configs.telescope")
    end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("plugins.configs.colorizer")
    end
  }
  use {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require("plugins.configs.nvimwebdevicons")
    end,
  }
  --use {
  --  'ggandor/lightspeed.nvim',
  --  config = function()
  --    require("plugins.configs.lightspeed")
  --  end
  --}
  use {
    'stevearc/aerial.nvim',
    setup = function()
      require("core.utils").load_mappings("aerial")
    end,
    config = function()
      require("plugins.configs.aerial")
    end
  }
  use { "akinsho/toggleterm.nvim", tag = '*',
    setup = function()
      require("core.utils").load_mappings("toggleterm")
    end,
    config = function()
      require("plugins.configs.toggleterm")
    end,
  }
end


local present, packer = pcall(require, "packer")

if present then
  vim.cmd "packadd packer.nvim"

  packer.startup(plugins)
end
