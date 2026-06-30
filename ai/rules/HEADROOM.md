## Headroom MCP — Context Compression Tools

Headroom exposes three MCP tools for on-demand context compression. **Use them proactively** to keep the context window lean without losing information. Compression is reversible: originals are cached locally and retrievable by hash.

---

## Available Tools

| Tool | Purpose | Key Params |
|------|---------|-----------|
| `headroom_compress` | Shrink large content before reasoning over it. Returns compressed text + a `hash` + token savings. | `content` (required, string) |
| `headroom_retrieve` | Fetch the original (or a filtered subset) of previously compressed content. | `hash` (required, string), `query` (optional, string — BM25 filter) |
| `headroom_stats` | Inspect this session's compression activity: counts, tokens saved, recent events. | none |

---

## When to Compress

**Call `headroom_compress` when you receive a tool output that is large and you only need the gist.** Concretely:

- **Long file dumps** (hundreds/thousands of lines) where you need structure, not every line.
- **Broad search results** (grep/glob/ast-grep returning many matches) — compress the full list, keep the hash.
- **Build/test/CI logs** that are verbose but largely repetitive.
- **Large JSON/structured output** (API responses, dependency trees) where keys matter more than values.
- **Repeated or verbose content** that would sit in context for several turns.

**Do NOT compress when:**

- The output is small (under ~50 lines / ~400 tokens). Compression overhead isn't worth it; the router will likely `noop` it anyway.
- The output is an **error, stack trace, or debug detail** you need verbatim. The router protects these (`router:protected:error_output`) — respect that and keep them raw.
- You need to quote/modify exact lines immediately (just read directly).
- The content is time-sensitive and you'll need the full version within one turn.

**After compressing, ALWAYS keep the `hash`** in your working context. You'll need it to retrieve the original later.

---

## When to Retrieve

**Call `headroom_retrieve` when the compressed version is missing a detail you actually need.** Triggers:

- The compressed summary references something but lacks the exact line/value/identifier you now need.
- The user asks a follow-up whose answer is in the original large output you compressed earlier.
- You're about to edit code based on a compressed file dump and need exact line numbers/content.

**Prefer the `query` parameter for partial retrieval** when you know what you're looking for:

```
headroom_retrieve(hash="abc123", query="authentication error handler")
```

BM25 filtering returns only matching items — fewer tokens, faster reasoning. Only do a full retrieval (no `query`) when you genuinely need everything back.

**⚠ TTL limit:** Originals are cached locally for **1 hour** after compression. If you compressed long ago and `retrieve` returns nothing, the original is gone — re-read the source instead of retrying.

---

## When to Check Stats

Call `headroom_stats` sparingly — only when:

- The user asks how much context you're saving.
- You suspect compression isn't firing (all recent events show `noop`/`protected`) and want to verify.
- You're diagnosing why a `retrieve` failed (check if the compression event exists).

Do not call it routinely; it adds noise without value.

---

## Workflow Example

```
1. You run `grep -r "auth" src/` → 800 matches returned.
2. Output is large. Call headroom_compress(content="<the 800 matches>").
   → Returns: compressed summary, hash=7f3a..., savings 78%
3. Reason over the compressed summary to plan the task.
4. User asks: "show me the exact line in login.py that checks the password".
5. Call headroom_retrieve(hash="7f3a...", query="login.py password").
   → Returns only the matching lines. Use them.
```

---

## Key Constraints

- **Keep the hash.** Without it, you cannot retrieve. Treat the hash like a reference to the original.
- **1-hour TTL.** Compressed originals expire. Re-read from source if retrieval comes up empty.
- **Router is conservative by design.** `noop` means "not worth compressing" — trust it. `protected` means "this looks sensitive" — keep it raw. You cannot force compression past the router.
- **No double-compression.** Don't compress already-compressed content. If a tool output came through the headroom proxy (look for `[N items compressed... hash=...]` markers), use `headroom_retrieve` with that hash instead of calling `headroom_compress` again.
- **Compression is reduction, not summarization.** The compressed version preserves structure (keys, signatures, types, error strings) and trims verbosity (long values, repeated patterns, comments). It is safe to reason over for most tasks.

---

**This rule is working if:** your context stays lean on large-tool-output turns, you rarely lose information you end up needing, and when you do need detail you retrieve it by hash instead of re-running the original tool.
