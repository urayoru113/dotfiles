{
  description = "Modern Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    hermes-agent.url = "github:NousResearch/hermes-agent/v2026.5.16";
  };

  outputs = {
    self,
    nixpkgs-stable,
    home-manager,
    hermes-agent,
    ...
  }: let
    system = "x86_64-linux";
  in {
    homeConfigurations.urayoru = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs-stable.legacyPackages.${system};
      modules = [./home.nix];
      extraSpecialArgs = {inherit hermes-agent;};
    };
  };
}
