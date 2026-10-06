# Project Layout — noizu_google_mcp

Elixir MCP server exposing Google API tools (Search Console, Analytics, AdSense, Ads) over stdio.
Version 0.1.1 · Elixir ~1.18 / OTP 28.

```
elixir-google-mcp/
├── lib/noizu/google/mcp/         # Source → [layout/lib.md](layout/lib.md)
│   ├── mcp.ex                    #   Server entry + tool dispatch
│   ├── application.ex            #   OTP supervision (starts MCP stdio loop)
│   ├── auth.ex                   #   Token acquisition (service account / refresh / access)
│   ├── writes.ex                 #   Write-gate policy (GOOGLE_MCP_WRITES, dry_run, confirm)
│   └── tools/                    #   Google API tool modules by product namespace
│       ├── ads/                  #   4 tools — campaigns, conversion actions, mutate
│       ├── adsense/              #   3 tools — accounts, ad units, reports
│       ├── analytics/            #   4 tools — properties, data streams, run_report
│       └── search_console/       #   8 tools — sites, sitemaps, search analytics
├── config/
│   └── config.exs                # Compile-time config (logger, defaults)
├── test/
│   ├── auth_test.exs             #   Auth token-path tests
│   ├── writes_test.exs           #   Write-gate policy tests
│   └── test_helper.exs
├── bin/
│   └── noizu-google-mcp          # Stdio launcher; cds into project (Grok cwd-less hosts)
├── doc/                          # GENERATED — ExDoc output (gitignored)
├── .mcp.json.example             # Copy relevant block into .mcp.json / .cursor/mcp.json /
│                                 #   .vscode/mcp.json; documents env vars (stdio only)
├── .tool-versions # elixir 1.18.4-otp-28, erlang 28.5
├── .formatter.exs
├── mix.exs                       # Hex package metadata; docs config
├── mix.lock
├── CHANGELOG.md
├── CLAUDE.md / AGENT.md / AGENTS.md # Agent guidance
├── LICENSE
└── README.md                     # Start here — install, config, MCP host setup
```

## Key Files Requiring Setup

| File | Action |
|------|--------|
| `.mcp.json` (host-side) | Copy from `.mcp.json.example`; set `GOOGLE_APPLICATION_CREDENTIALS` to service-account JSON path, fill Ads tokens if used |
| `GOOGLE_MCP_WRITES=1` | Opt-in env var to enable write tools (Ads mutates still default to `dry_run`; `confirm=true` for live applies) |
| `GOOGLE_SCOPES` | Scope(s) for token; default `webmasters` (Search Console) |

## Notes

- `_build/`, `deps/`, `doc/`, `erl_crash.dump`, `noizu_google_mcp-*.tar` are gitignored build artifacts — do not document or commit.
- Stdio transport only; never expose over unauthenticated HTTP (see `.mcp.json.example` comment).
- `.claude/worktrees/` is the canonical worktree placement (gitignored).
