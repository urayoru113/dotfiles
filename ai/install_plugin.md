# oh-my-openagent 安裝指南

> 適用於使用 `OPENCODE_CONFIG_DIR` 指向自訂配置目錄的環境

## 問題背景

oh-my-openagent 安裝器會更新 `opencode.jsonc` 並生成 agent 配置檔，但**不會自動安裝 `node_modules`**。這導致插件雖然已註冊，但 opencode 找不到實際檔案，agent 列表不會出現。

## 最小必要步驟

```bash
# 1. 進入配置目錄
cd ~/.dotfiles/config/opencode

# 2. 執行官方安裝器（更新配置、生成 agent 定義）
bunx oh-my-openagent install \
  --no-tui \
  --platform=opencode \
  --claude=no \
  --gemini=no \
  --copilot=no

# 3. 安裝依賴（關鍵步驟！補上安裝器漏掉的 node_modules）
bun install
```

## 驗證安裝

```bash
# 檢查 agent 列表是否出現 oh-my-openagent 的 agent
OPENCODE_CONFIG_DIR="$HOME/.dotfiles/config/opencode" opencode agent list | grep -E "Sisyphus|Prometheus|Atlas|Hephaestus"
```

應該看到：
- Sisyphus - ultraworker
- Hephaestus - Deep Agent
- Prometheus - Plan Builder
- Atlas - Plan Executor
- Metis - Plan Consultant
- Momus - Plan Critic

## 注意事項

- 安裝器參數 `--claude`, `--gemini`, `--copilot` 為必填，即使沒有訂閱也要指定 `--claude=no`
- `bun install` 是**必要步驟**，不可省略
- 如果之前安裝過，建議先清理舊的 `node_modules/oh-my-openagent*` 和 `~/.cache/opencode/packages/oh-my-openagent*`
