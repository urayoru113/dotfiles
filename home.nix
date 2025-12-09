{
  config,
  pkgs,
  lib,
  ...
}: let
  shellAliases = {
    # Modern tool replacements
    ls = "eza";
    ll = "eza -la";
    la = "eza -a";
    lt = "eza --tree";
    cat = "bat";
    du = "dust";
    df = "duf";

    # Navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };
in {
  home.username = "urayoru";
  home.homeDirectory = "/home/urayoru";
  home.stateVersion = "25.05";
  home.sessionVariables = {
    STARSHIP_CONFIG = "$HOME/.dotfiles/starship.toml";
  };

  home.packages = with pkgs; [
    # System tools
    gcc
    gnumake
    luajit

    # Terminal utilities
    bottom # System monitor(Rust)
    btop # System monitor (C++)
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
    sd # Better sed
    procs # Better ps

    # Git related
    lazygit # Git TUI
    gh # GitHub CLI
    git-lfs # Git large file support
    delta # Git diff improvement
    difftastic # Git diff improvement

    # Development tools
    # Note: Language environments go in devShells, not here!

    # File processing
    jq # JSON processor
    yq # YAML processor

    # Network tools
    httpie # HTTP client
    socat # Bidirectional data transfer
    rsync # Sync remote file

    # Other utilities
    tldr # Simplified man pages
    tree # Directory tree
    unzip # Decompression
    zip # Compression
  ];

  home.activation.cleanupNvimLink = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -L "$HOME/.config/nvim" ]; then
      $DRY_RUN_CMD rm "$HOME/.config/nvim"
    fi
    if [ -L "$HOME/.tmux.conf" ]; then
      $DRY_RUN_CMD rm "$HOME/.tmux.conf"
    fi
  '';

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";
    };
    # ".tmux.conf" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.tmux.conf";
    # };
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

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "urayoru";
          email = ""; # Remember to change!
        };
      };
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
        merge.tool = "nvimdiff";
        merge.conflictStyle = "zdiff3";

        # delta
        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "catppuccin";
        };

        # difftastic 配置
        diff.tool = "difftastic";
        difftool.prompt = false;
      };

      aliases = {
        difftool-any = "!git diff --no-index";
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
      mouse = true;

      extraConfig = ''
        # Basic config
        bind-key M-p send-prefix # if you press <M-p><M-p>
        set-option -a terminal-overrides ",*256col*:RGB"

        # Reload config
        bind r source-file $HOME/.dotfiles/.tmux.conf \; display "Config reloaded!"

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
      options = [
        "--cmd cd"
      ];
    };

    bash = {
      enable = true;

      # ===== For LOGIN shells (after nix environment loaded) =====
      profileExtra = ''
        # On non-NixOS systems, source Nix environment manually
        # (Home Manager doesn't add this automatically)
        if [ -e /home/urayoru/.nix-profile/etc/profile.d/nix.sh ]; then
          . /home/urayoru/.nix-profile/etc/profile.d/nix.sh;
        fi

        if [ -z "$ZSH_VERSION" ] && command -v zsh &> /dev/null; then
          exec zsh -l
        fi
      '';
      inherit shellAliases;
    };

    zsh = {
      enable = true;
      enableCompletion = false;

      autosuggestion = {
        enable = true;
        strategy = [
          "history"
          "completion"
        ];
      };
      historySubstringSearch = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };

      profileExtra = ''
        # On non-NixOS systems, source Nix environment manually
        # (Home Manager doesn't add this automatically)
        if [ -e /home/urayoru/.nix-profile/etc/profile.d/nix.sh ]; then
          . /home/urayoru/.nix-profile/etc/profile.d/nix.sh;
        fi

        [ -f ~/.dotfiles/.zshrc ] && source ~/.dotfiles/.zshrc
      '';
      initContent = ''
        fpath+=${pkgs.zsh-completions}/share/zsh/site-functions
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';

      inherit shellAliases;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
    };

    starship = {
      enable = true;
    };

    zellij = {
      enable = true;
    };
  };

  xdg.enable = true;
  # allow unfree packages
  nixpkgs.config.allowunfree = true;
}
