# OpenCode Plugin Auto-Installer

When instructed to install OpenCode plugins, follow these steps exactly in order.

## Pre-flight Checks

```bash
# 檢查 OpenCode 和相關工具
test -f ~/.local/bin/opencode && echo "OK: opencode" || echo "MISSING: opencode"
test -f ~/.local/bin/ocx && echo "OK: ocx" || echo "MISSING: ocx"
export PATH="$HOME/.bun/bin:$PATH"
which bun >/dev/null 2>&1 && echo "OK: bun" || echo "MISSING: bun"

# 檢查環境變數設定
echo "Checking environment variables..."
echo "OpenCode config should be at: ~/.dotfiles/config/opencode/opencode.jsonc"

# 檢查配置文件
if [ -f ~/.dotfiles/config/opencode/opencode.jsonc ]; then
  echo "OK: Reference config exists"
else
  echo "MISSING: Reference config"
fi

# 檢查實際使用的配置
if [ -f .opencode/opencode.json ]; then
  echo "OK: Local config exists"
else
  echo "MISSING: Local config"
fi

if [ -f ~/.config/opencode/opencode.json ]; then
  echo "OK: Global config exists"
else
  echo "MISSING: Global config"
fi
```

If any are missing, install them before proceeding.

## Plugins to Install

| # | Plugin | Method | Purpose |
|---|--------|--------|---------|
| 1 | `oh-my-openagent` | `bunx oh-my-openagent install` 或 `npm install oh-my-openagent` | Agent orchestration, LSP/AST-Grep tools |
| 2 | `@tarquinen/opencode-dcp` | plugin array in config 或 `opencode plugin @tarquinen/opencode-dcp@latest --global` | Dynamic context pruning (token saving) |
| 3 | `@zenobius/opencode-skillful` | plugin array in config 或 `npm install @zenobius/opencode-skillful` | On-demand skill loading |
| 4 | `opencode-mem` | plugin array in config 或 `npm install opencode-mem` | Persistent memory with local vector DB |
| 5 | `@plannotator/opencode` | plugin array in config 或 `npm install @plannotator/opencode` | Visual plan & code review in browser |
| 6 | `kdco/worktree` | OCX (`ocx add`) | Git worktrees with auto-spawned terminals |

**Key concept:** Plugins #2-#5 are OpenCode native plugins。OpenCode 使用以下配置檔案：

### 配置檔案位置
1. **參考配置**: `~/.dotfiles/config/opencode/opencode.jsonc` - 用戶設定的環境變數指向此位置
2. **本地配置**: `<project_dir>/.opencode/opencode.json` - OpenCode 優先使用
3. **全局配置**: `~/.config/opencode/opencode.json` - 備用

### 環境變數設定
用戶設定了環境變數，OpenCode 應該使用參考配置檔案。如果環境變數未生效，需要手動同步配置：

```bash
# 同步配置到本地配置
cp ~/.dotfiles/config/opencode/opencode.jsonc .opencode/opencode.json

# 同步配置到全局配置
cp ~/.dotfiles/config/opencode/opencode.jsonc ~/.config/opencode/opencode.json
```

**重要**: 必須檢查當前工作目錄的 `.opencode/opencode.json` 檔案，確保包含所有需要的 plugins。

**版本資訊 (截至 2026-05-30):**
- `oh-my-openagent`: 4.5.1
- `@tarquinen/opencode-dcp`: 3.1.12
- `@zenobius/opencode-skillful`: 1.2.5
- `opencode-mem`: 2.14.3
- `@plannotator/opencode`: 0.19.24

## Step 1: Install oh-my-openagent

This plugin uses its own installer (not the OpenCode plugin system):

```bash
bunx oh-my-openagent install --no-tui \
  --claude=no --openai=no --gemini=yes \
  --copilot=no --opencode-go=yes
```

或者使用 npm 安裝：
```bash
npm install oh-my-openagent
```

Expected outcomes:
- Plugin entry added to `~/.dotfiles/config/opencode/opencode.jsonc`
- Config written to `~/.dotfiles/config/opencode/oh-my-openagent.json`

**Note:** Multi-agent features only activate with the `ultrawork` keyword. Normal usage is unaffected.

## Step 2: Add Native Plugins to opencode.jsonc

**必須檢查三個配置檔案：**

### 1. 檢查參考配置（環境變數指向）
```bash
# 檢查參考配置檔案
if [ -f ~/.dotfiles/config/opencode/opencode.jsonc ]; then
  echo "Reference config exists"
  cat ~/.dotfiles/config/opencode/opencode.jsonc
else
  echo "MISSING: Reference config"
fi
```

### 2. 檢查本地配置
```bash
# 檢查當前工作目錄的本地配置
if [ -f .opencode/opencode.json ]; then
  echo "Local config exists"
  cat .opencode/opencode.json
else
  echo "No local config found"
fi
```

### 3. 檢查全局配置
```bash
# 檢查全局配置
if [ -f ~/.config/opencode/opencode.json ]; then
  echo "Global config exists"
  cat ~/.config/opencode/opencode.json
else
  echo "No global config found"
fi
```

### 4. 同步配置檔案
如果環境變數未生效，需要手動同步配置：

```bash
# 同步到本地配置
cp ~/.dotfiles/config/opencode/opencode.jsonc .opencode/opencode.json

# 同步到全局配置
cp ~/.dotfiles/config/opencode/opencode.jsonc ~/.config/opencode/opencode.json
```

### 5. 更新配置檔案
確保 `"plugin"` 陣列包含所有 5 個 entries：

```json
{
  "plugin": [
    "oh-my-openagent@latest",
    "@tarquinen/opencode-dcp@latest",
    "@zenobius/opencode-skillful@latest",
    "opencode-mem@latest",
    "@plannotator/opencode@latest"
  ]
}
```

**優先更新本地配置**，因為 OpenCode 優先使用本地配置。

### Plugin 詳細說明

#### oh-my-openagent
- **用途**: OpenCode 的多模型 Agent 編排框架，將單個 AI Agent 轉變為協調的開發團隊
- **安裝**: `bunx oh-my-openagent install` 或 `npm install oh-my-openagent`
- **注意**: 舊名 `oh-my-opencode` 仍可使用，建議優先使用 `oh-my-openagent`

#### @tarquinen/opencode-dcp
- **用途**: 動態上下文修剪，通過修剪過時的工具輸出減少 Token 使用量
- **安裝**: `opencode plugin @tarquinen/opencode-dcp@latest --global` 或在 `opencode.json` 中加入
- **注意**: 會自動在 `~/.config/opencode/dcp.jsonc` 或 `.opencode/dcp.jsonc` 建立配置文件

#### @zenobius/opencode-skillful
- **用途**: 實現 Anthropic Agent Skills 規範，提供懶加載的技能發現與注入功能
- **安裝**: `npm install @zenobius/opencode-skillful` 或 `opencode plugin @zenobius/opencode-skillful@latest --global`
- **注意**: 需在 `opencode.json` 的 `plugin` 陣列中加入

#### opencode-mem
- **用途**: 為編碼 Agent 提供基於本地向量資料庫的持久化記憶功能
- **安裝**: `npm install opencode-mem` 或 `opencode plugin opencode-mem@latest --global`
- **注意**: 依賴於 `@opencode-ai/plugin` 與 `@opencode-ai/sdk`

#### @plannotator/opencode
- **用途**: 提供互動式計畫審查功能，支援對計畫進行視覺化標註
- **安裝**: `npm install @plannotator/opencode` 或 `opencode plugin @plannotator/opencode@latest --global`
- **注意**: 安裝時會執行 `postinstall` 腳本，將指令文件複製到 `~/.config/opencode/commands/`

## Step 3: Install Plugins

### 方法 A: 使用 opencode plugin 命令（推薦）
```bash
# 安裝單個 plugin（本地）
opencode plugin @plannotator/opencode@latest

# 安裝單個 plugin（全局）
opencode plugin @plannotator/opencode@latest --global

# 安裝所有 plugins
for plugin in "oh-my-openagent@latest" "@tarquinen/opencode-dcp@latest" "@zenobius/opencode-skillful@latest" "opencode-mem@latest" "@plannotator/opencode@latest"; do
  opencode plugin $plugin --global
done
```

### 方法 B: OpenCode 自動安裝
修改配置檔案後，啟動 OpenCode。它會自動安裝 `"plugin"` 陣列中缺少的 plugins。

### 安裝位置
OpenCode 將 plugins 安裝在：
- `/home/urayoru/.cache/opencode/packages/` - 快取位置
- 不是 `/home/urayoru/.config/opencode/plugins/`

## Step 4: Install OCX + opencode-worktree

`kdco/worktree` is NOT an OpenCode plugin. It uses OCX (OpenCode extension manager).

**4a. Install OCX:**
```bash
curl -fsSL https://ocx.kdco.dev/install.sh | sh
```

**4b. Initialize and install:**
```bash
ocx init --global
ocx registry add https://registry.kdco.dev --name kdco --global
ocx add kdco/worktree --global
```

Expected: "✓ Done! Installed 2 components."

## Step 5: Verify

### 1. 檢查配置檔案
```bash
# 檢查參考配置（環境變數指向）
echo "=== Reference config (environment variable) ==="
cat ~/.dotfiles/config/opencode/opencode.jsonc 2>/dev/null || echo "No reference config"

# 檢查本地配置
echo "=== Local config ==="
cat .opencode/opencode.json 2>/dev/null || echo "No local config"

# 檢查全局配置
echo "=== Global config ==="
cat ~/.config/opencode/opencode.json 2>/dev/null || echo "No global config"
```

### 2. 檢查安裝狀態
```bash
# 檢查 plugins 是否安裝在快取中
echo "=== Checking plugin installation ==="
find ~/.cache/opencode/packages -name "package.json" | xargs grep -l "plannotator\|dcp\|skillful\|mem\|openagent" 2>/dev/null || echo "No plugins found in cache"

# 檢查 OCX 安裝
echo "=== Checking OCX installation ==="
ocx list --global 2>/dev/null || echo "OCX not installed"
```

### 3. 驗證 OpenCode 可以載入 plugins
```bash
echo "=== Checking OpenCode plugin list ==="
opencode plugin list 2>/dev/null || echo "Cannot list plugins"
```

### 4. 檢查環境變數
```bash
echo "=== Checking environment variables ==="
env | grep -i opencode
env | grep -i config
```

**預期結果：**
- `"plugin"` 陣列應包含所有 5 個 plugin 名稱
- `ocx list` 輸出應顯示 `worktree` 已安裝
- 所有配置檔案應同步一致

## Notes

- User wants background tools (LSP/AST-Grep) only — never suggest `ultrawork` or multi-agent orchestration
- User prefers concise, direct answers
- User communicates in Chinese (Traditional/Simplified mixed) and English
- Never modify `~/.dotfiles/flake.nix` or `~/.dotfiles/home.nix` — managed separately

## 環境變數配置

### 重要設定
用戶設定了環境變數，OpenCode 應該使用以下配置文件：
- **參考配置**: `~/.dotfiles/config/opencode/opencode.jsonc`

### 環境變數檢查
```bash
# 檢查環境變數設定
echo "OpenCode config path: $OPENCODE_CONFIG_PATH"
echo "OpenCode config file: $OPENCODE_CONFIG_FILE"

# 如果環境變數未設定，設定它們
if [ -z "$OPENCODE_CONFIG_PATH" ]; then
  export OPENCODE_CONFIG_PATH="$HOME/.dotfiles/config/opencode"
fi

if [ -z "$OPENCODE_CONFIG_FILE" ]; then
  export OPENCODE_CONFIG_FILE="$HOME/.dotfiles/config/opencode/opencode.jsonc"
fi
```

### 配置同步
如果環境變數未生效，需要手動同步配置：
```bash
# 同步到本地配置
cp "$OPENCODE_CONFIG_FILE" ".opencode/opencode.json"

# 同步到全局配置
cp "$OPENCODE_CONFIG_FILE" "$HOME/.config/opencode/opencode.json"
```

## 常見問題

### 1. Plugin 沒有安裝
**原因**: OpenCode 優先使用本地配置 `<project_dir>/.opencode/opencode.json`，而不是全局配置。
**解決**: 檢查並更新本地配置檔案。

### 2. 找不到安裝的 plugins
**原因**: OpenCode 將 plugins 安裝在 `/home/urayoru/.cache/opencode/packages/`，而不是 `/home/urayoru/.config/opencode/plugins/`。
**解決**: 使用 `find ~/.cache/opencode/packages -name "package.json"` 檢查安裝狀態。

### 3. 配置檔案名稱不一致
**原因**: OpenCode 使用 `opencode.json`（不是 `opencode.jsonc`）。
**解決**: 確保使用正確的檔案名稱。

### 4. 安裝命令混淆
**原因**: `opencode plugin` 命令需要指定 module 名稱，不能直接運行 `opencode plugin`。
**解決**: 使用 `opencode plugin <module-name>@latest --global`。

### 5. 環境變數設定
**原因**: 用戶設定了環境變數，OpenCode 應該使用 `~/.dotfiles/config/opencode/opencode.jsonc` 配置文件。
**解決**: 
1. 確認環境變數設定正確
2. 檢查 OpenCode 是否正確讀取環境變數
3. 如果環境變數未生效，需要手動同步配置文件到實際使用的配置位置
