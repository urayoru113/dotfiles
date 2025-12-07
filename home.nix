{
  config,
  pkgs,
  ...
}: let
  shellAliases = {
    # Modern tool replacements
    ls = "eza";
    ll = "eza -la";
    la = "eza -a";
    lt = "eza --tree";
    cat = "bat";

    # System
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };
in {
  home.username = "urayoru";
  home.homeDirectory = "/home/urayoru";
  home.stateVersion = "25.05";
  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh"; # Hint to applications
  };
  home.packages = with pkgs; [
    # System tools
    gcc
    gnumake
    luajit

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
    socat # Bidirectional data transfer

    # Other utilities
    tldr # Simplified man pages
    tree # Directory tree
    unzip # Decompression
    zip # Compression
  ];

  home.file = {
    ".config/nvim" = {source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";};
  };

  programs = {
    neovim = {
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

    git = {
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

    tmux = {
      enable = true;
      terminal = "screen-256color";
      keyMode = "vi";
      prefix = "M-p";
      escapeTime = 0;
      historyLimit = 10000;

      extraConfig = ''
        # Mouse support
        set -g mouse on

        # Reload config
        bind r source-file ~/.tmux.conf \; display "Config reloaded!"

        # Split windows (more intuitive)
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # Vim-style pane switching
        bind M-h select-pane -L
        bind M-j select-pane -D
        bind M-k select-pane -U
        bind M-l select-pane -R

        # Quick pane switching
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Status bar styling
        set -g status-style bg=black,fg=white
        set -g status-left-length 40
        set -g status-left "#[fg=green]Session: #S #[fg=yellow]#I #[fg=cyan]#P"
        set -g status-right "#[fg=cyan]%d %b %R"
      '';
    };

    zoxide = {
      enable = true;
    };

    bash = {
      enable = true;
      initExtra = ''
        # Auto-exec zsh for interactive sessions
        if [[ $- == *i* ]] && command -v zsh &> /dev/null; then
          if [ -z "$ZSH_VERSION" ] && [ -z "$BASH_NO_ZSH" ]; then
            exec zsh
          fi
        fi
      '';
      inherit shellAliases;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      inherit shellAliases;
    };
  };
  xdg.enable = true;
  # allow unfree packages
  nixpkgs.config.allowunfree = true;
}
