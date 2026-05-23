# dotfiles

Personal configuration files managed with Nix Flakes and Home Manager, featuring a heavily modular Neovim setup.

## ✨ Features

- **❄️ Nix Flakes + Home Manager** — Reproducible, declarative system configuration
- ** Neovim** — Modular setup with 80+ plugins, Lazy.nvim, ~200ms startup
- **🤖 AI-Ready Editor** — CodeCompanion (4 LLM providers + ACP), Avante, Gemini, Windsurf, Supermaven, and more
- **🔧 Full LSP/DAP** — Python, Lua, Java, Nix, Bash, JSON, TOML with debugging support
- **✨ Starship Prompt** — Catppuccin Latte theme, 30+ language runtime detection
- ** Terminal** — Zellij (primary) + Tmux (legacy) with vim-style keybindings
- **🚀 Modern CLI Tools** — eza, bat, fd, ripgrep, zoxide, delta, difftastic, lazygit, and more

## 🚀 Quick Start

```bash
git clone https://github.com/urayoru113/dotfiles ~/.dotfiles
nix run home-manager -- switch --flake .
```

## 📁 Structure

```
~/.dotfiles/
├── flake.nix              # Nix Flake entry point
├── home.nix               # Home Manager configuration (packages, programs, shell)
├── flake.lock             # Locked Nix dependencies
├── .env                   # Local environment variables (API keys) — gitignored
├── .env.example           # Template for environment variables
├── .gitignore
│
├── config/                # Application configs (symlinked via home.nix)
│   ├── nvim/              # Full Neovim configuration
│   ├── starship.toml      # Starship prompt theme
│   ├── starship/
│   ├── zellij/            # Zellij config
│   └── opencode.jsonc     # OpenCode AI agent config
│
├── home/                  # Legacy dotfiles sourced by home.nix
│   ├── .zshrc
│   ├── .bashrc
│   ├── .tmux.conf
│   └── .wezterm.lua
│
└── ai/rules/AGENTS.md     # AI coding assistant guidelines
```

## ❄️ Nix / Home Manager

**`flake.nix`** — Single-user flake for `x86_64-linux`:
- **nixpkgs**: nixpkgs-stable (`nixos-25.11`)
- **home-manager**: release 25.11
- **hermes-agent**: NousResearch Hermes AI agent

**`home.nix`** — Declares everything in one place:
- **Shell aliases**: `ls` → `eza`, `cat` → `bat`, `du` → `dust`, `df` → `duf`
- **35+ packages**: CLI tools, Git tools, system utils, AI agents
- **Programs**: Neovim, Git (delta + difftastic), Zsh, Tmux, Starship, direnv, zoxide, Jujutsu

##  Neovim

### Architecture

```
init.lua → core/ (options, keymaps, autocmds, utils, highlights)
         → plugins/lazy/ (11 categories, 80+ plugins)
         → lsp/ (10 language server configs)
```

### Plugin Categories

| Category | Plugins |
|----------|---------|
| **AI** | CodeCompanion, Avante, Gemini, opencode.nvim, Windsurf, Parrot, Supermaven |
| **LSP** | blink.cmp, mason, lspconfig, lspsaga, trouble, lint, format, treesitter |
| **Completion** | blink.cmp, luasnip, codeium, minuet, colorful-menu |
| **Editing** | mini.surround, nvim-autopairs, flash, vim-visual-multi, better-escape, tabout |
| **Navigation** | Telescope, neo-tree, nvim-tree, aerial, grug-far, nvim-navbuddy |
| **Git** | gitsigns, neogit, lazygit |
| **UI** | lualine, bufferline, indent-blankline, alpha (greeter), nvim-notify, zen-mode |
| **Utility** | which-key, auto-session, todo-comments, neotest, snacks.nvim |

### LSP Servers

Python (`pyright`, `ruff`), Lua (`lua_ls`, `emmylua_ls`), Java (`jdtls`), Nix (`nil_ls`), Bash (`bashls`), JSON/TOML (`jsonls`, `taplo`)

### Key Highlights

- **Format on save** — controlled via `vim.b.do_format` flag
- **Boolean toggle** — `<C-t>` toggles `true/false`, `True/False`
- **Run current file** — `<F9>` per-filetype (python, lua, c, cpp, sh, markdown)
- **Debug mode** — `<F6>` toggle, single-letter DAP keymaps in debug mode
- **Python project detection** — auto-detects venv, poetry, pyenv
- **AI code review** — CodeCompanion with custom prompt library

## ✨ Starship Prompt

Catppuccin Latte theme with custom color palette. Right-side displays **30+ language runtimes** including Node, Bun, Deno, Python, Rust, Go, Java, Kotlin, Scala, C, C++, Ruby, PHP, Lua, Perl, Elixir, Haskell, OCaml, Nim, Zig, Swift, Dart, Julia, and more.

##  Zellij / Tmux

**Zellij** (primary) — vim-style keybindings (hjkl focus), locked default mode, pane management with v/s/o splits.
**Tmux** (legacy) — Alt-p prefix, vim pane switching with Alt+hjkl, mouse support.

## 🔧 Shell

**Zsh** (primary) — oh-my-zsh with autosuggestions, syntax highlighting, history substring search, fzf-tab completion, zsh-vi-mode.
**Bash** (fallback) — sourced via Home Manager, falls through to `exec zsh -l`.

## 🔒 Notes

### Environment Variables

Copy `.env.example` to `.env` and fill in your API keys:

```bash
cp .env.example ~/.dotfiles/.env
# Edit .env with your keys
```

`.env` is gitignored by default and sourced automatically by `.zshrc`.

### Dependencies (non-Nix)

- Nix with Flakes enabled
- Neovim >= 0.10 (managed by Nix)

## 📄 License

MIT
