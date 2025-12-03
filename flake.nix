{
  description = "A reproducible development environment with common dev tools.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; 
  };

  outputs = { self, nixpkgs, ... }: {
    devShells.default = nixpkgs.lib.makeSimplerShell {
      packages = with nixpkgs.legacyPackages.x86_64-linux; [ 
        git         
        curl        
        nodejs_24
        neovim      
        rustup      
      ];
    };
  };
}