# PROJ-ARCH (summary) — noizu_google_mcp

Stateless Elixir MCP server (stdio) exposing Google marketing APIs (Search Console, GA4, AdSense, Ads) as tools. Thin layer over the `noizu_google` SDK; Hex package `noizu_google_mcp` v0.1.1.

- **Server**: `Noizu.Google.MCP` (`noizu_google`) — registers 19 tools, dispatches, filters listing through write gate.
- **Application**: OTP supervisor starts `{Noizu.Google.MCP, transport: :stdio}` unless `start_stdio: false` (test env).
- **Auth**: env-only resolution per call — access token → service-account JSON (file or inline) → OAuth refresh trio; `GOOGLE_MARKETING_*` aliases accepted.
- **Write gate**: `GOOGLE_MCP_WRITES=1` opt-in; 6 write tools hidden from `tools/list` and rejected at dispatch; Ads writes default `dry_run=true` + require `confirm=true` for live applies.
- **Data flow**: host stdio → tools/list (filtered) → tools/call → gate → tool → Auth.client → noizu_google SDK → Google API.
- **Deps**: `noizu_mcp ~> 0.1.5`, `noizu_google` (local sibling path `../../api/elixir-google` if present, else Hex `~> 0.2.4`), jason.
- **No persistence**: no DB, no KV, no cached tokens. Stdio only — never HTTP.
