# Oh My OpenAgent — Agent 完整指南

> 資料來源：https://omo.dev/zh/docs#agent-model-matching
> 整理時間：2026-05-26

## 一、Agent 角色、任務與模型對應

### 👑 Sisyphus — 主協調者

**角色**: 紀律性代理人 / 總管

**任務**:
- 規劃、委派專門代理人並以激進的平行執行方式推動任務完成
- 不會 halfway 停止或被分心，一定會把事情做完
- 作為總管，負責將複雜任務分解並分配給適合的專門代理人
- 管理 background agents、累積跨任務經驗、協調所有子代理人

**適用場景**: 任何需要協調、規劃和任務分配的複雜專案

**模型類別**: Communicator（溝通型）→ 需要 Claude 系模型  
**Fallback 鏈**: Claude Opus 4.7 → Kimi K2.6 → Kimi K2.5 → GPT-5.5 → GLM-5 → Big Pickle

---

### ⚒️ Hephaestus — 自主深度工作者

**角色**: 合法的工匠 / 自主深度專家

**任務**:
- 探索代碼庫、研究模式並端到端執行而不需要持續指導
- 進行深度架構推理、跨檔案複雜除錯或跨域知識綜合
- 當工作需要 GPT-5.5 特別優勢時明確切換使用
- 給定一個目標而非食譜，自主完成所有工作

**適用場景**: 深度技術問題、架構設計、複雜除錯、需要原則驅動推理的任務

**模型類別**: Deep Specialist（深度專家）→ 需要 GPT 系模型，**不要用 Claude 替代**  
**Fallback 鏈**: GPT-5.5（唯一選擇，無 fallback）

---

### 🎯 Prometheus — 策略規劃者

**角色**: 策略規劃者 / 諮詢顧問

**任務**:
- 像真正的工程師一樣進行面試式提問
- 識別範圍和歧義，在寫第一行代碼前建立詳細計劃
- 透過 Tab 鍵進入 Prometheus 模式，或從 Sisyphus 輸入 `@plan "你的任務"`
- 負責預規劃階段，確保執行前有清晰的路線圖

**適用場景**: 需要澄清需求、規劃架構、識別風險點的專案開始階段

**模型類別**: Dual-Prompt Agent（雙提示）→ Claude 優先，GPT 支援  
**Fallback 鏈**: Claude Opus 4.7 → GPT-5.5 → GLM-5.1 → Gemini 3.1 Pro  
**注意**: 同時內建 Claude 版和 GPT 版提示，會自動偵測模型並切換

---

### 🎼 Atlas — 指揮家

**角色**: Todo 協調者 / 執行指揮

**任務**:
- 執行 Prometheus 制定的計劃
- 將任務分配給專門的子代理人
- 累積跨任務的學習經驗（前一個任務發現的慣例會傳遞給後續任務）
- 獨立驗證任務完成度
- 透過 `/start-work` 指令在最新計劃上激活 Atlas

**適用場景**: 需要任務分派、進度追蹤和品質驗證的執行階段

**模型類別**: Dual-Prompt Agent（雙提示）→ Claude 優先，GPT 支援  
**Fallback 鏈**: Claude Sonnet 4.6 → Kimi K2.6 → GPT-5.5 → MiniMax M2.7

---

### 🔮 Oracle — 架構顧問

**角色**: 高 IQ 諮詢顧問 / 架構決策智囊

**任務**:
- 提供只讀的高智慧諮詢服務
- 在面對不熟悉的模式、安全顧慮或多系統權衡時進行諮詢
- 作為架構決策和複雜除錯的智囊團

**適用場景**: 架構評估、安全審查、技術選型、跨系統整合評估

**模型類別**: Deep Specialist（深度專家）→ 需要 GPT 系模型  
**Fallback 鏈**: GPT-5.5 → Gemini 3.1 Pro → Claude Opus 4.7 → GLM-5.1

---

### ⚖️ Momus — 嚴格審查者

**角色**: 無情的審查者 / 品質保證者

**任務**:
- 批判性地檢查代碼的品質、正確性和標準遵守程度
- 作為質量保證者，確保代碼達到高標準
- 提供嚴格的代碼審查和品質控制

**適用場景**: 代碼品質檢查、安全審查、規範遵守檢查、發布前最終驗證

**模型類別**: Deep Specialist（深度專家）→ 需要 GPT 系模型  
**Fallback 鏈**: GPT-5.5 (xhigh) → Claude Opus 4.7 → Gemini 3.1 Pro → GLM-5.1

---

### 📚 Librarian — 文檔搜尋專家

**角色**: 文檔/代碼搜尋專家 / 知識管理者

**任務**:
- 在代碼庫和外部庫中尋找相關範例、模式和解決方案
- 進行文檔和代碼搜尋
- 快速定位現有實作和最佳實踐

**適用場景**: 查找現有代碼、尋找實作範例、研究技術文檔

**模型類別**: Utility Runner（工具型）→ 速度優先於智慧，**不要用 Opus 升級**  
**Fallback 鏈**: GPT-5.4 Mini Fast → Qwen3.5-plus → MiniMax M2.7 Highspeed → MiniMax M2.7 → Claude Haiku 4.5 → GPT-5.4 Nano

---

### 🔍 Explore — 快速勘探者

**角色**: 快速 codebase grep / 偵察兵

**任務**:
- 快速搜尋檔案以找到特定模式、實作或參考
- 進行代碼庫的快速掃描和模式匹配

**適用場景**: 快速定位代碼片段、搜尋特定函數或變數、模式匹配

**模型類別**: Utility Runner（工具型）→ 速度優先於智慧，**不要用 Opus 升級**  
**Fallback 鏈**: GPT-5.4 Mini Fast → Qwen3.5-plus → MiniMax M2.7 Highspeed → MiniMax M2.7 → Claude Haiku 4.5 → GPT-5.4 Nano

---

### 🔍 Metis — 間隙分析者

**角色**: 差距分析師 / 需求分析者

**任務**:
- 識別當前狀態與目標之間的差距
- 幫助定義需要建構或學習的內容
- 找出缺失的環節和必要的行動

**適用場景**: 需求分析、技術評估、學習規劃、技能差距識別

**模型類別**: Communicator（溝通型）→ 需要 Claude 系模型  
**Fallback 鏈**: Claude Sonnet 4.6 → Claude Opus 4.7 → GPT-5.5 → GLM-5.1 → K2.5

---

### 👦 Sisyphus-Junior — 任務執行者

**角色**: 類別任務執行者 / 執行層

**任務**:
- 處理 Sisyphus 委派的具體任務，專注且高效
- 負責具體任務的實作

**適用場景**: 具體編碼任務、功能實作、Bug 修復、小型開發工作

**模型類別**: Utility Runner（工具型）→ 速度優先  
**Fallback 鏈**: Claude Sonnet 4.6 → Kimi K2.6 → GPT-5.5 → MiniMax M2.7 → Big Pickle

---

### 👁️‍🗨️ Multimodal Looker — 視覺處理專家

**角色**: 多模態觀察者 / 視覺專家

**任務**:
- 分析截圖、圖表和視覺元素
- 進行前端和設計相關的視覺任務

**適用場景**: 前端開發、UI/UX 設計、視覺回饋處理、設計稿實作

**模型類別**: Utility Runner（工具型）→ 速度優先  
**Fallback 鏈**: GPT-5.5 → Kimi K2.6 → GLM 4.6v → GPT-5 Nano

---

## 二、模型家族概覽

### Claude 系（溝通型、指令遵循）

擅長：複雜多步驟指令、對話流、結構化輸出

| 模型 | 特點 |
|------|------|
| **Claude Opus 4.7** | 最強遵循性，Sisyphus 預設首選 |
| **Claude Sonnet 4.6** | 更快更便宜，日常任務夠用 |
| **Claude Haiku 4.5** | 速度快價格低，utility 任務適用 |
| **Kimi K2.6 / K2.5** | Claude 行為的最佳替代品，opencode-go 首選 |
| **GLM 5 / GLM 5.1** | 類 Claude，nested workflow 稍弱但穩定 |
| **Big Pickle (GLM 4.6)** | 免費備援選項 |

> **Kimi ≻ GLM**：Kimi 在 Sisyphus 的 nested todo+delegation prompt 下表現更好。

### GPT 系（原則型、自主推理）

擅長：自主探索、深度技術問題、目標導向執行

| 模型 | 特點 |
|------|------|
| **GPT-5.5** | 高階推理，Hephaestus 理論上要用的模型 |
| **GPT-5.3 Codex** | 深度編碼能力，自主探索強力 |
| **GPT-5.4 Mini** | 快速 + 強推理，quick category 預設 |
| **GPT-5.4 Mini Fast** | Explore / Librarian 預設，極快 |
| **GPT-5-Nano** | 超便宜快速，簡單 utility 任務 |

> **DeepSeek ≻≻ MiniMax**：DeepSeek 保留了 GPT 的自主探索特性；MiniMax 在深度多步驟任務中會失去一致性。

### Gemini 系（視覺型、不同推理風格）

擅長：前端 UI/UX、CSS、設計決策

| 模型 | 特點 |
|------|------|
| **Gemini 3.1 Pro** | 視覺任務首選，visual-engineering / artistry 預設 |
| **Gemini 3 Flash** | 快速版，寫作/文檔任務 |
| **Qwen 3.6-plus / 3.5-plus** | Gemini 的最佳替代方案（視覺任務） |

> 不要用 Kimi/GLM 替代 Gemini 做視覺任務。

---

## 三、Task Category 對應表

Sisyphus 委派任務時不會選模型名稱，而是選 **category**，系統自動映射。

| Category | 用途 | 預設模型 | Fallback 鏈 |
|----------|------|----------|-------------|
| **visual-engineering** | 前端、UI、CSS、設計 | Gemini 3.1 Pro (high) | Gemini → GLM-5 → Claude Opus 4.7 → GLM-5.1 → K2.5 |
| **artistry** | 創意、新穎方法 | Gemini 3.1 Pro (high) | Gemini → Claude Opus 4.7 → GPT-5.5 |
| **ultrabrain** | 需要最高推理能力 | GPT-5.5 (xhigh) | GPT-5.5 xhigh → Gemini 3.1 Pro → Claude Opus 4.7 → GLM-5.1 |
| **deep** | 深度編碼、複雜邏輯 | GPT-5.5 (medium) | GPT-5.5 → Claude Opus 4.7 → Gemini 3.1 Pro |
| **quick** | 簡單快速任務 | GPT-5.4 Mini | GPT-5.4-mini → Claude Haiku 4.5 → Gemini 3-Flash → MiniMax M2.7 → GPT-5 Nano |
| **unspecified-high** | 一般複雜工作 | Claude Opus 4.7 (max) | Opus → GPT-5.5 → GLM-5 → K2.5 → GLM-5.1 → K2.5 |
| **unspecified-low** | 一般標準工作 | Claude Sonnet 4.6 | Sonnet → GPT-5.3 Codex → Kimi K2.6 → Gemini 3-Flash → MiniMax M2.7 |
| **writing** | 文字、文檔、散文 | K2.5 | Gemini 3-Flash → Kimi K2.6 → Claude Sonnet 4.6 → MiniMax M2.7 |

---

## 四、OpenCode Go 可用模型

OpenCode Go 是 $10/mo 的訂閱制，提供中國前沿模型的穩定存取：

| 模型 | 用途 |
|------|------|
| `opencode-go/kimi-k2.6` | 視覺能力、類 Claude 推理。Sisyphus、Atlas、Sisyphus-Junior、Multimodal Looker |
| `opencode-go/glm-5.1` | 純文字協調模型。Oracle、Prometheus、Metis、Momus |
| `opencode-go/minimax-m2.7` | 超便宜快速回應。Atlas、Sisyphus-Junior、Explore/Librarian 備援 |
| `opencode-go/qwen3.5-plus` | Qwen 編碼模型。Explore/Librarian 第一備援 |

---

## 五、替換速查（Cheat Sheet）

### 如果失去 Claude Opus/Sonnet
**替换順序**：Kimi K2.5/K2.6 → GLM 5 → Big Pickle  
**絕對避免**：舊版 GPT 模型

### 如果失去 GPT-5.4/5.5
**替换順序**：GPT-5.3 Codex → DeepSeek v3.2  
**絕對避免**：MiniMax（utility 工作除外）

### 如果失去 Gemini 3.1 Pro
**替换順序**：Qwen 3.6-plus / 3.5-plus  
**絕對避免**：Claude/Kimi，這些不是 Gemini 的視覺替代品

### 如果失去 Grok Code Fast 1（Explore 用）
**替换順序**：GPT-5.4 Mini Fast → MiniMax M2.7 Highspeed → Claude Haiku  
**絕對避免**：Opus（浪費成本）

---

## 六、安全 vs 危險的 Override

### ✅ 安全替換（同人格類型）

- **Sisyphus**: Opus → Sonnet、Kimi K2.5/2.6、GLM 5（都是溝通型模型）
- **Prometheus**: Opus → GPT-5.5（會自動切換到 GPT 提示）
- **Atlas**: Claude Sonnet 4.6 → Kimi K2.6 → GPT-5.5（會自動切換到 GPT 提示）

### ❌ 危險替換（人格錯配）

| 錯誤替換 | 原因 |
|----------|------|
| **Sisyphus → 舊 GPT 模型** | GPT-5.4/5.5 才有專用 prompt path，舊版不適用 |
| **Hephaestus → Claude** | Hephaestus 為 GPT 自主風格設計，Claude 無法複製 |
| **Hephaestus → MiniMax** | MiniMax 在深度多步驟任務中失去一致性 |
| **Oracle → MiniMax** | Oracle 需要持續推理，MiniMax 會漂移 |
| **Explore → Opus** | 嚴重浪費成本，Explore 只需要速度 |
| **Librarian → Opus** | 同上，文檔搜尋不需要 Opus 級推理 |
| **visual-engineering → Kimi/GLM** | 推理風格錯誤。用 Qwen，不要用 Claude 系 |

---

## 七、推薦配置方案

### 方案 A：最佳性價比（OpenCode Go + OpenAI Plus/Pro）~$30/mo

```json
{
  "agents": {
    "sisyphus": {
      "model": "opencode-go/kimi-k2.6",
      "ultrawork": { "model": "opencode-go/kimi-k2.6" }
    },
    "hephaestus": { "model": "openai/gpt-5.5", "variant": "medium" },
    "oracle": { "model": "openai/gpt-5.5", "variant": "high" },
    "prometheus": { "model": "opencode-go/kimi-k2.6" },
    "atlas": { "model": "opencode-go/kimi-k2.6" },
    "explore": { "model": "opencode-go/qwen3.5-plus" },
    "librarian": { "model": "opencode-go/qwen3.5-plus" }
  },
  "categories": {
    "visual-engineering": { "model": "opencode-go/qwen3.6-plus" },
    "deep": { "model": "openai/gpt-5.5", "variant": "medium" },
    "ultrabrain": { "model": "openai/gpt-5.5", "variant": "xhigh" },
    "quick": { "model": "openai/gpt-5.4-mini" },
    "unspecified-low": { "model": "opencode-go/kimi-k2.6" },
    "unspecified-high": { "model": "opencode-go/kimi-k2.6" },
    "writing": { "model": "opencode-go/kimi-k2.6" }
  }
}
```

**涵蓋範圍**：OpenCode Go ($10) 提供 Kimi/GLM/Qwen + OpenAI ($20+) 提供 GPT。比直接訂閱 Anthropic + OpenAI + Google（$60+）省一半以上。

### 方案 B：全原生（Anthropic + OpenAI + Google）最高品質、最高成本

```json
{
  "agents": {
    "sisyphus": { "model": "anthropic/claude-opus-4-7", "variant": "max" },
    "hephaestus": { "model": "openai/gpt-5.5", "variant": "medium" },
    "oracle": { "model": "openai/gpt-5.5", "variant": "high" }
  },
  "categories": {
    "visual-engineering": { "model": "google/gemini-3.1-pro", "variant": "high" },
    "deep": { "model": "openai/gpt-5.5", "variant": "medium" },
    "unspecified-high": { "model": "anthropic/claude-opus-4-7", "variant": "max" }
  }
}
```

### 方案 C：純 Go（預算有限，無 GPT）

```json
{
  "agents": {
    "sisyphus": { "model": "opencode-go/kimi-k2.6" },
    "atlas": { "model": "opencode-go/kimi-k2.6" },
    "oracle": { "model": "opencode-go/glm-5.1" },
    "explore": { "model": "opencode-go/qwen3.5-plus" },
    "librarian": { "model": "opencode-go/qwen3.5-plus" }
  },
  "categories": {
    "visual-engineering": { "model": "opencode-go/qwen3.6-plus" },
    "deep": { "model": "opencode-go/kimi-k2.6" },
    "unspecified-high": { "model": "opencode-go/kimi-k2.6" },
    "unspecified-low": { "model": "opencode-go/kimi-k2.6" },
    "quick": { "model": "opencode-go/minimax-m2.7" },
    "writing": { "model": "opencode-go/kimi-k2.6" }
  }
}
```

> ⚠️ Hephaestus 不會啟動（需要 GPT）。deep category 用 Kimi 不是理想替代，但已是最佳可用選項。

### 方案 D：加入 DeepSeek 作為 GPT 備援（透過 OpenRouter）

```json
{
  "agents": {
    "oracle": {
      "model": "openai/gpt-5.5",
      "variant": "high",
      "fallback_models": [
        "anthropic/claude-opus-4-7",
        { "model": "openrouter/deepseek/deepseek-v3.2", "temperature": 0.7 },
        "opencode-go/glm-5.1"
      ]
    }
  }
}
```

`fallback_models` 接受模型字串或帶有 `variant`、`reasoningEffort`、`temperature`、`top_p`、`maxTokens`、`thinking` 的物件。

---

## 八、模型解析優先級

```
1. 使用者 Override → 明確配置的 model
2. Category default → 從 category 配置
3. User fallback_models → 使用者指定的備援鏈
4. Provider fallback → AGENT_MODEL_REQUIREMENTS / CATEGORY_MODEL_REQUIREMENTS
5. System default → 最終安全網
```

**Core-agent tab 循環順序**（固定）：Sisyphus (0) → Hephaestus (1) → Prometheus (2) → Atlas (3) → 其餘 agents

**驗證實際模型分配**：`bunx oh-my-opencode doctor`

---

## 九、Agent 協作流程

```
User Request
    ↓
[IntentGate] — 分類你的意圖
    ↓
[Sisyphus] — 主協調者，規劃並委派
    ↓
    ├─→ [Prometheus] — 策略規劃（面試模式）
    ├─→ [Atlas] — Todo 協調與執行
    ├─→ [Oracle] — 架構諮詢
    ├─→ [Librarian] — 文檔/代碼搜尋
    ├─→ [Explore] — 快速 codebase grep
    └─→ [Category-based agents] — 按任務類型分派
```

1. **需求澄清階段**: Prometheus 進行訪談式提問，建立詳細計劃
2. **規劃分配階段**: Sisyphus 接受計劃並根據任務類型分配給專門代理人
3. **執行階段**: Atlas 執行計劃，將具體任務分派給 Explore、Librarian、Hephaestus 等專門代理人
4. **品質控制階段**: Momus 進行嚴格審查，Oracle 提供架構諮詢
5. **知識積累階段**: 所有代理人經驗被系統記錄，Metis 分析學習間隙
6. **任務完成**: Sisyphus 確認所有子任務完成並交付最終結果

---

*線上文件：https://omo.dev/zh/docs*
*源碼：https://github.com/code-yeongyu/oh-my-openagent*
