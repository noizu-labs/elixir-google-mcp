# THREAT-MODEL (summary) — noizu_google_mcp

Stdio-only MCP server granting read/write access to Google marketing accounts. No network listener; boundaries = host↔server (stdio), server↔Google (credentialed egress), filesystem↔server (SA JSON, sibling dep path). Crown jewels: Google credentials in env.

Register (9): 2 mitigated · 2 partial · 5 open/accepted.

- T-001 High/EoP — write tools agent-callable → mitigated: opt-in `GOOGLE_MCP_WRITES`, hidden from tools/list + dispatch rejection (`writes.ex`, `mcp.ex`)
- T-002 Med/EoP — prompt injection steering writes → partial: Ads dry_run/confirm latch, SC deletes need confirm, `destructive_hint` annotations; SC add/submit lack confirm
- T-003 Med/Disclosure — creds in env/host MCP config → accepted (stdio design)
- T-004 Low/Disclosure — error bodies inlined into tool results → open
- T-005 Med/Repudiation — no local audit log of mutations → open
- T-006 Med/Tampering — sibling dep path override controls SDK → accepted (dev convenience)
- T-007 Low/Spoofing — env-supplied tokens → accepted
- T-008 Low/DoS — crash kills MCP session → accepted
- T-009 Low/Tampering — bin launcher PATH prepend → accepted

Key residual: with writes enabled, confirm flags are machine-supplied — they rate-limit injection, not stop it. Never expose over unauthenticated HTTP.
