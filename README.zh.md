# dotfiles

以 Nix Flakes 和 Home Manager 管理的個人配置檔案，核心是一套高度模組化的 Neovim 設定。

## ✨ 特色

- **❄️ Nix Flakes + Home Manager** — 可複現、宣告式的系統配置管理
- ** Neovim** — 80+ 插件、Lazy.nvim、啟動僅 ~200ms
- **🤖 AI 開發環境** — CodeCompanion（4 個 LLM 提供商 + ACP）、Avante、Gemini、Windsurf、Supermaven 等
- **🔧 完整 LSP/DAP** — Python、Lua、Java、Nix、Bash、JSON、TOML，含除錯支援
- **✨ Starship 提示** — Catppuccin Latte 主題，30+ 語言執行環境自動偵測
- ** 終端管理** — Zellij（主力）+ Tmux（備用），Vim 風格快捷鍵
- **🚀 現代 CLI 工具** — eza、bat、fd、ripgrep、zoxide、delta、difftastic、lazygit 等

## 🚀 快速開始

```bash
git clone https://github.com/urayoru113/dotfiles ~/.dotfiles
nix run home-manager -- switch --flake .
```

## 📁 目錄結構

```
~/.dotfiles/
├── flake.nix              # Nix Flake 入口
├── home.nix               # Home Manager 配置（套件、程式、Shell）
├── flake.lock             # 鎖定的 Nix 依賴
├── .env                   # 環境變數（API keys）— 已加入 .gitignore
├── .env.example           # 環境變數範本
├── .gitignore
│
├── config/                # 應用程式設定（透過 home.nix 符號連結）
│   ├── nvim/              # Neovim 完整配置
│   ├── starship.toml      # Starship 主題
│   ├── starship/
│   ├── zellij/            # Zellij 設定
│   └── opencode.jsonc     # OpenCode AI agent 設定
│
├── home/                  # 被 home.nix 引入的設定檔
│   ├── .zshrc
│   ├── .bashrc
│   ├── .tmux.conf
│   └── .wezterm.lua
│
└── ai/rules/AGENTS.md     # AI 輔助編碼規範
```

## ❄️ Nix / Home Manager

**`flake.nix`** — 單使用者的 `x86_64-linux` flake：
- **nixpkgs**: nixpkgs-stable（`nixos-25.11`）
- **home-manager**: release 25.11
- **hermes-agent**: NousResearch Hermes AI agent

**`home.nix`** — 在一處宣告所有配置：
- **Shell 別名**：`ls` → `eza`、`cat` → `bat`、`du` → `dust`、`df` → `duf`
- **35+ 套件**：CLI 工具、Git 工具、系統工具、AI agent
- **程式管理**：Neovim、Git（delta + difftastic）、Zsh、Tmux、Starship、direnv、zoxide、Jujutsu

##  Neovim

### 架構

```
init.lua → core/（選項、快捷鍵、自動事件、工具函數、高亮）
         → plugins/lazy/（11 個分類，80+ 插件）
         → lsp/（10 個語言伺服器設定）
```

### 插件分類

| 分類 | 插件 |
|------|------|
| **AI** | CodeCompanion、Avante、Gemini、opencode.nvim、Windsurf、Parrot、Supermaven |
| **LSP** | blink.cmp、mason、lspconfig、lspsaga、trouble、lint、format、treesitter |
| **補全** | blink.cmp、luasnip、codeium、minuet、colorful-menu |
| **編輯** | mini.surround、nvim-autopairs、flash、vim-visual-multi、better-escape、tabout |
| **導航** | Telescope、neo-tree、nvim-tree、aerial、grug-far、nvim-navbuddy |
| **Git** | gitsigns、neogit、lazygit |
| **介面** | lualine、bufferline、indent-blankline、alpha（啟動畫面）、nvim-notify、zen-mode |
| **工具** | which-key、auto-session、todo-comments、neotest、snacks.nvim |

### LSP 伺服器

Python（`pyright`、`ruff`）、Lua（`lua_ls`、`emmylua_ls`）、Java（`jdtls`）、Nix（`nil_ls`）、Bash（`bashls`）、JSON/TOML（`jsonls`、`taplo`）

### 重點功能

- **儲存時自動格式化** — 透過 `vim.b.do_format` 標記控制
- **布林值切換** — `<C-t>` 切換 `true/false`、`True/False`
- **執行當前檔案** — `<F9>` 依檔案類型執行（python、lua、c、cpp、sh、markdown）
- **除錯模式** — `<F6>` 切換，除錯模式下單字母 DAP 快捷鍵
- **Python 專案偵測** — 自動偵測 venv、poetry、pyenv
- **AI Code Review** — CodeCompanion 自訂提示庫

## ✨ Starship 提示

Catppuccin Latte 主題搭配自訂色板。右側顯示 **30+ 語言執行環境**，包含 Node、Bun、Deno、Python、Rust、Go、Java、Kotlin、Scala、C、C++、Ruby、PHP、Lua、Perl、Elixir、Haskell、OCaml、Nim、Zig、Swift、Dart、Julia 等。

##  Zellij / Tmux

**Zellij**（主力）— Vim 風格快捷鍵（hjkl 移動焦點）、鎖定預設模式、v/s/o 分割視窗。
**Tmux**（備用）— Alt-p 前綴鍵、Alt+hjkl Vim 風格切換面板、滑鼠支援。

## 🔧 Shell

**Zsh**（主力）— oh-my-zsh 搭配 autosuggestions、syntax highlighting、history substring search、fzf-tab、zsh-vi-mode。
**Bash**（備用）— 由 Home Manager 管理，進入互動模式後 `exec zsh -l`。

## 🔒 注意事項

### 環境變數

複製 `.env.example` 為 `.env` 並填入你的 API keys：

```bash
cp .env.example ~/.dotfiles/.env
# 編輯 .env 填入你的金鑰
```

`.env` 已加入 `.gitignore`，由 `.zshrc` 自動引入。

### 非 Nix 依賴

- 啟用 Flakes 的 Nix
- Neovim >= 0.10（由 Nix 管理）

## 📄 授權

MIT
