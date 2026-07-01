{
  description = "Modern Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hermes-agent.url = "github:NousResearch/hermes-agent/v2026.6.19";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({config, ...}: {
      debug = true;
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

      flake = {
        homeConfigurations = builtins.listToAttrs (map (system: {
            name = "urayoru@${system}";
            value = inputs.home-manager.lib.homeManagerConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages.${system};
              modules = [./home.nix];
              extraSpecialArgs = {custom = inputs;};
            };
          })
          config.systems);
        templates.default = {
          path = ./templates/default;
          description = "Flake-parts project with nixd completion";
        };
      };

      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          packages = [pkgs.nixd];
        };
      };
    });
}
