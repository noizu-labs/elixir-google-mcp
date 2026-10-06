# PROJ-LAYOUT (summary) — noizu_google_mcp

Quick-reference tree; full descriptions in [PROJ-LAYOUT.md](PROJ-LAYOUT.md).

```
elixir-google-mcp/
├── lib/noizu/google/mcp/     # Source → layout/lib.md
│   ├── mcp.ex                #   Server entry + tool dispatch
│   ├── application.ex        #   OTP supervision
│   ├── auth.ex               #   Token acquisition
│   ├── writes.ex             #   Write-gate policy
│   └── tools/                #   ads/ adsense/ analytics/ search_console/
├── config/config.exs
├── test/                     # auth_test, writes_test, test_helper
├── bin/noizu-google-mcp      # stdio launcher
├── doc/                      # GENERATED ExDoc (gitignored)
├── .mcp.json.example         # MCP host config template (stdio only)
├── .tool-versions            # elixir 1.18.4-otp-28, erlang 28.5
├── .formatter.exs
├── mix.exs / mix.lock
├── CHANGELOG.md
├── CLAUDE.md / AGENT.md / AGENTS.md
├── LICENSE
└── README.md
```
