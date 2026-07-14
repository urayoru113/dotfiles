{
  config,
  pkgs,
  # lib,
  custom,
  user,
  ...
}: let
  shellAliases = {
    # Tool replacements
    ls = "eza --icons";
    ll = "eza -la --icons";
    la = "eza -a --icons";
    lt = "eza --tree --icons";
    tree = "eza --tree --icons";
    cat = "bat";
    du = "dust";
    df = "duf";
    sed = "sd";

    docker = "podman";

    fonts = "fc-list : family";

    # Navigation
    "-" = "cd -";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };

  shellInit = ''
    ns() {
      nix shell "''${@/#/nixpkgs#}"
    }
    nr() {
        local pkg="$1"
        shift
        nix run "nixpkgs#$pkg" -- "$@"
    }
    nix-init() {
      nix flake init -t "path:$HOME/.dotfiles#default" && nix flake lock
    }
    nix-new() {
      nix flake new -t "path:$HOME/.dotfiles#default" "$1" && cd "$1" && nix flake lock
    }
    hm-switch() {
      local sys
      case "$(uname -s)-$(uname -m)" in
        Linux-x86_64)  sys=x86_64-linux ;;
        Linux-aarch64) sys=aarch64-linux ;;
        Darwin-arm64)  sys=aarch64-darwin ;;
        *) echo "Unsupported: $(uname -s)-$(uname -m)"; return 1 ;;
      esac
      nix run home-manager -- switch --flake ".#${user}@''${sys}" "$@"
    }
  '';
in {
  services = {
    podman.enable = true;
  };

  fonts.fontconfig.enable = true; # Enable GUI font rendering

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";
    sessionVariables = {
      ZELLIJ_CONFIG_DIR = "$HOME/.dotfiles/config/zellij";
      OPENCODE_CONFIG_DIR = "$HOME/.dotfiles/config/opencode";
      YAZI_CONFIG_HOME = "$HOME/.dotfiles/config/yazi";
      OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS = 1;
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
    packages = with pkgs; [
      # System tools
      gnumake # Build tool
      openssh # SSH

      # Terminal utilities
      bottom # System monitor(Rust)
      btop # System monitor (C++)
      htop # Backup monitor
      ripgrep # Fast search
      fd # Fast file finder
      fzf # Fuzzy finder
      yazi # File explorer
      less # Pager
      fastfetch # System info
      eza # Better ls
      bat # Better cat
      zoxide # Smarter cd
      dust # Better du
      duf # Better df
      sd # Better sed
      procs # Better ps

      # Terminal multiplexer
      tmux
      zellij

      # Git related
      lazygit # Git TUI
      gh # GitHub CLI
      git-lfs # Git large file support
      delta # Git diff improvement
      difftastic # Git diff improvement
      opencommit # Generate commit messages

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
      unzip # Decompression
      zip # Compression
      lua55Packages.tree-sitter-cli # Tree sitter
      podman-compose # Compose podman containers
      pods # Podman desktop alternative
      wezterm # Terminal

      # Gui tools
      google-chrome # Web browser

      # Project Manager & runner & builder
      gcc
      uv
      bun
      luajit
      python314
      cargo
      go
      nodejs_24

      # ai
      # opencode Currently broken at nixpkgs 26.05
      vectorcode # AI assist
      (custom.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        extraDependencyGroups = ["messaging"];
      })
      rtk # Rust token killer

      # LSP servers
      ast-grep
      nixd
      pyright
      typescript-language-server
      nil
      alejandra
      yaml-language-server
    ];
  };

  programs = {
    neovim = {
      enable = true; # It seems to be that `true` will not load `~/.config/nvim/init.vim`
      defaultEditor = true;
      withPython3 = false;
      withNodeJs = false;
      withRuby = false;
      withPerl = false;
      sideloadInitLua = true;
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = user;
          email = ""; # Remember to change!
        };
      };
    };

    git = {
      enable = true;

      settings = {
        user = {
          name = user;
          email = ""; # Remember to change!
        };

        aliases = {
          difftool-any = "!git diff --no-index";
        };

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
        };

        # difftastic 配置
        diff.tool = "difft";
        difftool.prompt = false;
        difftool.difft.cmd = "difft '$LOCAL' '$REMOTE'";
      };

      ignores = [
        # OS
        ".DS_Store"
        "Thumbs.db"

        # Editors
        ".vscode/"
        ".idea/"
        ".env"
        "*.swp"
        "*.swo"
        "*~"
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
        bind r source-file $HOME/.dotfiles/home/.tmux.conf \; display "Config reloaded!"

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
      initExtra = ''
        # On non-NixOS systems, source Nix environment manually
        # (Home Manager doesn't add this automatically)
        if [ -e /home/${user}/.nix-profile/etc/profile.d/nix.sh ]; then
          . /home/${user}/.nix-profile/etc/profile.d/nix.sh;
        fi

        if [[ $- == *i* ]] && [ -z "$ZSH_VERSION" ] && command -v zsh &> /dev/null; then
          export SHELL="${pkgs.zsh}/bin/zsh"
          exec "$SHELL" -l
        fi
      '';
      inherit shellAliases;
    };

    zsh = {
      enable = true;
      enableCompletion = true;

      history = {
        size = 10000;
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        share = true;
        extended = true;
      };

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
      plugins = with pkgs; [
        {
          name = "zsh-vi-mode";
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          src = zsh-vi-mode;
        }
        {
          name = "zsh-fzf-tab";
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
          src = zsh-fzf-tab;
        }
        {
          name = "zsh-fast-syntax-highlighting";
          file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
          src = zsh-fast-syntax-highlighting;
        }
        {
          name = "zsh-you-should-use";
          file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
          src = zsh-you-should-use;
        }
      ];

      envExtra = ''
        if [[ -o interactive && "$NIX_ZSH_LOADED" != "1" ]]; then
          export NIX_ZSH_LOADED=1
          export SHELL="$HOME/.nix-profile/bin/zsh"
          exec "$SHELL" -l
        fi
      '';

      profileExtra = ''
        # On non-NixOS systems, source Nix environment manually
        # (Home Manager doesn't add this automatically)
        if [ -e /home/${user}/.nix-profile/etc/profile.d/nix.sh ]; then
          . /home/${user}/.nix-profile/etc/profile.d/nix.sh;
        fi

        # Load environment variables (API keys, etc.)
        [ -f ~/.dotfiles/.env ] && source ~/.dotfiles/.env
      '';
      initContent = ''
        ${shellInit}
        source ~/.dotfiles/home/.zshrc
      '';

      inherit shellAliases;
    };

    starship = {
      enable = true;
      configPath = "$HOME/.dotfiles/config/starship.toml";
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/nvim";
        force = true;
      };
      "fastfetch/config.jsonc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/fastfetch/config.jsonc";
        force = true;
      };
    };
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
  systemd.user.sockets.podman = {
    Unit = {
      Description = "Podman API Socket";
      Documentation = "man:podman-system-service(1)";
    };
    Socket = {
      # %t is systemd matic variable for /run/user/1001
      ListenStream = "%t/podman/podman.sock";
      SocketMode = "0600";
    };
    Install = {
      WantedBy = ["sockets.target"];
    };
  };
}
