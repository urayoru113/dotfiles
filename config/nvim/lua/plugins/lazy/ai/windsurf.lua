return {
  -- https://github.com/Exafunction/windsurf.nvim
  enable = true,
  "Exafunction/windsurf.nvim",
  name = "codeium",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
  },
  event = "InsertEnter",
  init = function()
    local json_str = [[
{
  "version": "1.48.2",
  "stamp": "e03af6ebc40b844314d448f947c80b636d093049",
  "hashes": {
    "x86_64-linux": "sha256-eBaRSc/yB+1pTPDyh6ABuAWaPUoakn+RGhryaYBY9F4=",
    "aarch64-linux": "sha256-lCFTWItfCRSvN5GQZpRe2WvOFIEmdwPVQQ42t5bQmyU=",
    "x86_64-darwin": "sha256-3llKuTcutSAlKeh1JfBrTMdY6Pt3U9Vqe1vUHXvn6Ww=",
    "aarch64-darwin": "sha256-QEqjJ0C4fPG9jaPaXCdJpxyFfRlG//HOuri9HYy4DJo=",
    "x86_64-windows": "sha256-a3lSAUBr63S443/dtFJNijbGAhUWhy8So6eIkiVA+8s="
  }
}
]];
    vim.fn.writefile(vim.split(json_str, "\n"),
      vim.fn.expand("~/.local/share/nvim/lazy/codeium/lua/codeium/versions.json"))
  end,
  opts = {
    enable_cmp_source = false,
    workspace_root = {
      use_lsp = true,
    },
    virtual_text = {
      enabled = true,
    },
  },
}
