local utils = require("core.utils")
return {
  settings = {
    nixd = {
      nixpkgs = {
        expr = string.format(
          'import (builtins.getFlake (toString ./.)).inputs.nixpkgs { system = "%s"; }',
          utils.get_os_target()
        ),
      },
      options = {
        ["home-manager"] = {
          expr = string.format(
            'let f = builtins.getFlake (toString ./.); in ((f.homeConfigurations or {})."urayoru@%s" or {}).options or {}',
            utils.get_os_target()
          ),
        },
        ["flake-parts"] = {
          expr = string.format(
            "let flake = builtins.getFlake (toString ./.); in flake.debug.options // flake.allSystems.%s.options",
            utils.get_os_target()
          ),
        },
      },
    },
  },
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
}
