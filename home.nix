{
  config,
  pkgs,
  ...
}: {
  home.username = "urayoru";
  home.homeDirectory = "/home/urayoru";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    # Terminal utilities
    btop # System monitor (personal use)
    htop # Backup monitor
    ripgrep # Fast search
    fd # Fast file finder
    fzf # Fuzzy finder
    tmux # Terminal multiplexer

    # Modern alternatives
    eza # Better ls
    bat # Better cat
    zoxide # Smarter cd
    dust # Better du
    duf # Better df

    # Git related
    lazygit # Git TUI
    gh # GitHub CLI
    git-lfs # Git large file support

    # Development tools
    # Note: Language environments go in devShells, not here!

    # File processing
    jq # JSON processor
    yq # YAML processor

    # Network tools
    httpie # HTTP client

    # Other utilities
    tldr # Simplified man pages
    tree # Directory tree
    unzip # Decompression
    zip # Compression
  ];

  # Neovim full configuration
  programs.neovim = {
    enable = true; # It seems to be that `true` will not load `~/.config/nvim/init.vim`
    defaultEditor = true;
    extraPackages = with pkgs; [
      # python
      pyright
      ruff

      # lua
      lua-language-server

      # nix
      nil
      alejandra
    ];
  };

  # Git full configuration
  programs.git = {
    enable = true;
    userName = "urayoru";
    userEmail = ""; # Remember to change!

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      diff.tool = "nvimdiff";
      merge.tool = "nvimdiff";
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      cm = "commit -m";
      last = "log -1 HEAD";
      unstage = "reset HEAD --";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };

    ignores = [
      # OS
      ".DS_Store"
      "Thumbs.db"

      # Editors
      ".vscode/"
      ".idea/"
      "*.swp"
      "*.swo"
      "*~"
    ];
  };

  xdg.enable = true;
  # allow unfree packages
  nixpkgs.config.allowunfree = true;
}
