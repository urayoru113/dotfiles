{
  description = "A reproducible development environment with common dev tools.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = {
    self,
    nixpkgs-stable,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs-stable {inherit system;};
    packages = with pkgs; [
      curl
      git
      jq
      nix-tree
    ];
  in {
    devShells.${system}.default = pkgs.mkShell {
      inherit packages;
    };
    packages.${system}.dev-tools = pkgs.buildEnv {
      name = "dev-tools-env";
      paths = packages;
    };
    homeConfigurations.urayoru = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs-stable.legacyPackages.x86_64-linux;
      modules = [./home.nix];
    };
  };
}
