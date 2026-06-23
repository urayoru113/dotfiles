local dotfiles_path = vim.fn.expand("~/.dotfiles")

return {
  settings = {
    nixd = {
      nixpkgs = {
        expr = [[import (builtins.getFlake "]] .. dotfiles_path .. [[").inputs.nixpkgs-stable { }]],
      },
      options = {
        ["home-manager"] = {
          expr = [[(builtins.getFlake "]] .. dotfiles_path .. [[").homeConfigurations.urayoru.options]],
        },
      },
    },
  },
}
