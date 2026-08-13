# Noizu Google MCP

[![Hex.pm](https://img.shields.io/hexpm/v/noizu_google_mcp.svg)](https://hex.pm/packages/noizu_google_mcp)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/noizu_google_mcp/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/noizu-labs/elixir-google-mcp/blob/main/LICENSE)

MCP **server** wrapping [`:noizu_google`](https://hex.pm/packages/noizu_google)
for agent/terminal access to Google marketing APIs (Search Console, GA4
Admin/Data, AdSense, Google Ads).

Built on [`:noizu_mcp`](https://hex.pm/packages/noizu_mcp). Speaks MCP over
**stdio** when the application starts (`mix run --no-halt`).

## Installation

```elixir
def deps do
  [
    {:noizu_google_mcp, "~> 0.1.0"}
  ]
end
```

Runtime dependencies are `:noizu_mcp`, `:noizu_google`, and Jason.

## Auth (environment)

| Variable | Purpose |
|----------|---------|
| `GOOGLE_ACCESS_TOKEN` | Bearer token (preferred for short sessions) |
| `GOOGLE_REFRESH_TOKEN` | Refresh when access token absent |
| `GOOGLE_CLIENT_ID` / `GOOGLE_CLIENT_SECRET` | Required for refresh |

Aliases: `GOOGLE_MARKETING_*` for the same keys.

Google Ads tools also need a developer token (`GOOGLE_ADS_DEVELOPER_TOKEN`)
and, for MCC logins, `GOOGLE_ADS_LOGIN_CUSTOMER_ID`. Obtain tokens with the
OAuth Mix tasks in `:noizu_google` (`mix google.oauth.authorize` /
`mix google.oauth.exchange`).

## Run (stdio)

From this project, or any Mix project that depends on it:

```sh
mix deps.get
export GOOGLE_ACCESS_TOKEN=...
mix run --no-halt
```

The application starts `{Noizu.Google.MCP, transport: :stdio}` unless you set:

```elixir
config :noizu_google_mcp, start_stdio: false
```

Use that when embedding the server in your own supervisor (tests already
disable stdio so `mix test` does not attach to stdin).

### Claude / agent config

```json
{
  "mcpServers": {
    "noizu-google": {
      "command": "mix",
      "args": ["run", "--no-halt"],
      "cwd": "/absolute/path/to/elixir-google-mcp",
      "env": {
        "GOOGLE_ACCESS_TOKEN": "..."
      }
    }
  }
}
```

A checked-in template lives in [`.mcp.json.example`](.mcp.json.example).

## Tools

| Tool | Category | Notes |
|------|----------|--------|
| `SearchConsole.SitesList` | SearchConsole | read |
| `SearchConsole.SitesGet` | SearchConsole | read |
| `SearchConsole.SitesAdd` | SearchConsole | write |
| `SearchConsole.SitesDelete` | SearchConsole | destructive (`confirm`) |
| `SearchConsole.SearchAnalyticsQuery` | SearchConsole | read |
| `SearchConsole.SitemapsList` | SearchConsole | read |
| `SearchConsole.SitemapsSubmit` | SearchConsole | write |
| `SearchConsole.SitemapsDelete` | SearchConsole | destructive (`confirm`) |
| `Analytics.PropertiesList` | Analytics | read |
| `Analytics.PropertiesGet` | Analytics | read |
| `Analytics.DataStreamsList` | Analytics | read |
| `Analytics.RunReport` | Analytics | read |
| `AdSense.AccountsList` | AdSense | read |
| `AdSense.AdUnitsList` | AdSense | read |
| `AdSense.ReportsGenerate` | AdSense | read |
| `Ads.ListCampaigns` | Ads | read; needs developer token |
| `Ads.ListConversionActions` | Ads | read; needs developer token |
| `Ads.Mutate` | Ads | **dry_run default**; live needs `confirm` |
| `Ads.CreateConversionAction` | Ads | **dry_run default**; live needs `confirm` |

Prefer read-only tools unless the user explicitly asks to mutate.

## Embed

```elixir
children = [
  {Noizu.Google.MCP, transport: :stdio}
]
```

Or Streamable HTTP if you already run a `:noizu_mcp` HTTP transport — pass the
same options `Noizu.MCP.Server` accepts.

`Noizu.Google.MCP.Auth.client/0` builds a `%Noizu.Google.Client{}` from the
environment / `:noizu_google` application config and refreshes when only a
refresh token is set.

## Development

```sh
mix deps.get
mix test
mix docs
mix hex.build          # tarball only; does not publish
```

## License

[MIT](https://github.com/noizu-labs/elixir-google-mcp/blob/main/LICENSE)
