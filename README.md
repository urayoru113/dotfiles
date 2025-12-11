# dotfiles
My personal configuration files.

## Neovim
A modular Neovim setup with Lazy.nvim plugin management.

Startup time: **~200ms**, extremely fast.

### requirements
- npm
- unzip
- curl
- make
- lua>=5.1
- gnumake
- gcc
- neovim

### optional
- ripgrep

### Features
- LSP, completion Blink, formatting, debugging
- AI integrations (CodeCompanion, Minuet)
- Advanced editing (autopairs, surround, flash)
- File explorer, Telescope, Lualine, Git integration
- Auto-session, markdown, terminal, zen mode

## Installation
```bash
git clone https://github.com/urayoru113/dotfiles ~/.dotfiles
nix run home-manager -- switch --flake .
```