## Headroom — Working-Memory Swap File

Headroom is a **context compression layer** for AI agents. Use it to manage context space and retrieve compressed content on demand. Compress anything: files, logs, conversation material, search results — not just tool outputs.

### Tools

| Tool | Purpose |
|------|---------|
| `headroom_compress(content)` | Compress content → shorter text + `hash`. Originals cached 1hr, retrievable. |
| `headroom_retrieve(hash, query?)` | Get original by hash. `query` does BM25 partial retrieval. |
| `headroom_stats` | Session compression stats (use sparingly). |

### Compress: Pruning vs Reversible Compression

| Tool | When |
|------|------|
| built-in `compress` | **Default** — prunes unnecessary info, keeps essential summary |
| `headroom_compress` | When you may need exact original details later (reversible) |

**Default: prefer `compress`.** It trims noise and keeps signal — the summary becomes the new truth. Use `headroom_compress` only when you might need to retrieve exact original content later this session.

To save context space while keeping reversibility: `headroom_compress` the content, then use `compress` to replace the original conversation with a summary referencing the hash. Original stays retrievable.

### Triggers

Compress when:
- One artifact: ~80-100+ lines or ~800-1200+ tokens
- Several recent reads/searches: ~2500-3000+ tokens combined
- Switching subtasks while old material occupies space
- User pastes massive log/JSON/docs

Don't compress when:
- Small (<50 lines / ~400 tokens)
- Need verbatim in the immediate next step
- Actively debugging from a precise stack trace

### Retrieve: Where Data Lives

1. Compressed with Headroom this session? → `headroom_retrieve(hash, query?)`
2. Durable cross-session memory? → `codemem_memory_search`
3. Current codebase/filesystem? → `grep` / `glob` / `ast_grep_search`

Retrieved content is a **snapshot**, not current state. Re-read source if freshness matters.

### Rules

- **Keep the hash** — annotate: `[Compressed Logs: hash=abc123]`
- **1hr TTL** — if retrieval returns nothing, re-read from source. Don't retry.
- **No double-compression** — if content has `[N items compressed... hash=...]` marker, retrieve instead
- **Router** — `noop` = not worth compressing, accept raw; `protected` = sensitive, keep raw. Don't force.
- **Prefer `query`** for partial retrieval over full fetch

### Failure Modes

| Pitfall | Action |
|---------|--------|
| Lost hash | Can't retrieve. Always annotate hash with description. |
| TTL expired | Re-read from source. Don't retry retrieval. |
| Over-compression | Don't compress small/immediately-needed content. |
| Double-compression | Check for existing hash marker first. |
| Router rejected | Accept raw, move on. Don't retry. |
| Stale snapshot | Re-read source if freshness matters. |

### Example

```
# 500-line file read arrives
headroom_compress(content) → compressed text + hash=abc123
# Reason over compressed text; later need exact line:
headroom_retrieve("abc123", query="line 42 error handler")
```
