---
description: Build a knowledge graph from code, docs, papers, images, and video
---

Load the graphify skill and follow its workflow.
Target: $ARGUMENTS

## Usage Reference
- `/graphify [path]` — build graph for folder
- `/graphify [path] --update` — re-extract changed files only
- `/graphify [path] --mode deep` — thorough extraction
- `/graphify [path] --cluster-only` — rerun clustering
- `/graphify [path] --directed` — preserve edge direction
- `/graphify [path] --no-viz` — skip HTML visualization
- `/graphify [path] --svg` — export graph.svg
- `/graphify [path] --graphml` — export for Gephi/yEd
- `/graphify [path] --neo4j` — generate cypher.txt
- `/graphify [path] --falkordb` — generate cypher.txt for FalkorDB
- `/graphify [path] --mcp` — start MCP stdio server
- `/graphify [path] --watch` — auto-sync on file changes
- `/graphify [path] --wiki` — build agent-crawlable markdown wiki
- `/graphify [path] --obsidian` — generate Obsidian vault
- `/graphify query "question"` — query the graph
- `/graphify path "node1" "node2"` — shortest path between concepts
- `/graphify explain "node"` — plain-language explanation
- `/graphify add <url>` — fetch URL and update graph
