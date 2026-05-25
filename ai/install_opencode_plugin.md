# OpenCode Plugin Auto-Installer

When instructed to install OpenCode plugins, follow these steps exactly.

## Pre-requisites

- OpenCode >= 1.15.10 installed at `~/.local/bin/opencode`
- Bun installed and in PATH (`~/.bun/bin`)
- Gemini API key set as `GEMINI_API_KEY` environment variable
- OpenCode Go subscription active
- Home Manager + Nix flakes managing system packages
- LSP servers (Nix): ast-grep, lua-language-server, nixd, pyright, typescript-language-server, yaml-language-server

## Goals

1. Install oh-my-openagent (OmO) — LSP/AST-Grep tools, no multi-agent
2. Install Dynamic Context Pruning (DCP) — token-saving context compression
3. Install opencode-skillful — on-demand skill loading
4. Install opencode-mem — persistent memory with local vector DB
5. Verify all plugins are registered

## Step 1: Install oh-my-openagent

```bash
bunx oh-my-openagent install --no-tui \
  --claude=no --openai=no --gemini=yes \
  --copilot=no --opencode-go=yes
```

Creates:
- `~/.config/opencode/oh-my-openagent.json` — agent model config
- `~/.config/opencode/tui.json` — TUI plugin entry (create if missing)

Write TUI config if missing:
```json
{ "plugin": ["oh-my-openagent/tui@latest"] }
```

**Important:** Multi-agent features only activate with `ultrawork` keyword. Normal usage is unaffected.

## Step 2: Install DCP

```bash
opencode plugin @tarquinen/opencode-dcp@latest --global
```

Auto-creates `~/.config/opencode/dcp.json` on first run. No manual config needed.

## Step 3: Install opencode-skillful

```bash
opencode plugin @zenobius/opencode-skillful@latest --global
```

Provides `skill_find`, `skill_use`, `skill_resource` tools for lazy-loaded skills.

## Step 4: Install opencode-mem

```bash
opencode plugin opencode-mem@latest --global
```

Persistent memory with local vector DB (SQLite + USearch). Features:
- Auto-captures facts/decisions/progress from conversations
- Learns user preferences, patterns, workflows over time
- Cross-session, cross-project memory search
- Web UI at `http://127.0.0.1:4747`
- Config: `~/.config/opencode/opencode-mem.jsonc`
- Data: `~/.opencode-mem/data/`

## Step 5: Verify

Check `~/.config/opencode/opencode.json` contains:
```json
{
  "plugin": [
    "oh-my-openagent@latest",
    "@tarquinen/opencode-dcp@latest",
    "@zenobius/opencode-skillful@latest",
    "opencode-mem@latest"
  ]
}
```

## Notes

- User does NOT want multi-agent orchestration — never suggest `ultrawork` or agent delegation
- User prefers concise, direct answers without excessive formatting
- User communicates in Chinese (Traditional/Simplified mixed) and English
- Never modify `~/.dotfiles/config/opencode.jsonc` — managed separately
- Never modify `~/.dotfiles/flake.nix` or `~/.dotfiles/home.nix` — managed separately
