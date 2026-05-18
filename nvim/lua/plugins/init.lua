M.lazy = function()
  local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if vim.fn.isdirectory(install_path) == 0 then
    print("Cloning lazy ..")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      install_path,
    })
  end
  vim.opt.rtp:prepend(install_path)

  local plugins = {
    { import = "plugins.lazy.ai" },
    { import = "plugins.lazy.colorschemes" },
    { import = "plugins.lazy.editor" },
    { import = "plugins.lazy.framework" },
    { import = "plugins.lazy.git" },
    { import = "plugins.lazy.input" },
    { import = "plugins.lazy.lsp" },
    { import = "plugins.lazy.misc" },
    { import = "plugins.lazy.motion" },
    { import = "plugins.lazy.nav" },
    { import = "plugins.lazy.ui" },
    { import = "plugins.lazy.utility" },
  }

  local options = {
    concurrency = math.min(8, math.max(1, math.ceil(vim.uv.available_parallelism() / 2))),
    git = {
      throttle = {
        enabled = true, -- not enabled by default
        -- max 4 ops every 5 seconds
        rate = 4,
        duration = 5 * 1000, -- in ms
      },
    },

    change_detection = {
      notify = false,
      enabled = true,
    },
    ui = {
      border = "single",
    },
  }

  require("lazy").setup(plugins, options)

  vim.cmd("silent! colorscheme tokyonight")
end

return M
