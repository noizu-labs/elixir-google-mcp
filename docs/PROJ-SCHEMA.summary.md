# PROJ-SCHEMA (summary) — noizu_google_mcp

No relational store — stateless stdio MCP server. Data = tool contracts + env config.
Full detail: [PROJ-SCHEMA.md](PROJ-SCHEMA.md), [schema/mcp-tools.md](schema/mcp-tools.md).

## Tool inventory (19)

| Category | Tool | Kind |
|----------|------|------|
| SearchConsole | SitesList, SitesGet, SearchAnalyticsQuery, SitemapsList | read |
| SearchConsole | SitesAdd, SitesDelete, SitemapsSubmit, SitemapsDelete | **gated write** |
| Analytics | PropertiesList, PropertiesGet, DataStreamsList, RunReport | read |
| AdSense | AccountsList, AdUnitsList, ReportsGenerate | read |
| Ads | ListCampaigns, ListConversionActions | read |
| Ads | CreateConversionAction, Mutate | **gated write** (dry_run default, confirm=true for live) |

## Env config (key vars)

- Auth: `GOOGLE_ACCESS_TOKEN` → `GOOGLE_APPLICATION_CREDENTIALS`/`GOOGLE_SERVICE_ACCOUNT_JSON` → `GOOGLE_REFRESH_TOKEN`+`GOOGLE_CLIENT_ID`+`GOOGLE_CLIENT_SECRET` (order of resolution)
- `GOOGLE_SCOPES` (default webmasters), `GOOGLE_SUBJECT`/`GOOGLE_IMPERSONATE`
- Ads: `GOOGLE_ADS_DEVELOPER_TOKEN`, `GOOGLE_ADS_LOGIN_CUSTOMER_ID`
- Writes: `GOOGLE_MCP_WRITES=1` opts in to the 6 write tools
