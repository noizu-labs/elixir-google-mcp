# lib/ — noizu_google_mcp source

Full breakdown of `lib/noizu/google/mcp/`. Detail also visible in [PROJ-LAYOUT.md](../PROJ-LAYOUT.md).

```
lib/noizu/google/mcp/
├── mcp.ex                           # Server entry: registers tools, dispatches MCP calls
├── application.ex                   # OTP Application — starts the MCP stdio server
├── auth.ex                          # Google auth: service account JWT → access token,
│                                    #   refresh-token flow, or supplied access token
├── writes.ex                        # Write-gate: GOOGLE_MCP_WRITES=1 opt-in;
│                                    #   Ads mutates default dry_run, confirm=true to apply
└── tools/
    ├── ads/                         # Google Ads (needs GOOGLE_ADS_DEVELOPER_TOKEN,
    │   │                            #   GOOGLE_ADS_LOGIN_CUSTOMER_ID)
    │   ├── list_campaigns.ex        #   Read campaigns
    │   ├── list_conversion_actions.ex # Read conversion actions
    │   ├── create_conversion_action.ex # Write (gated) — create conversion action
    │   └── mutate.ex                #   Write (gated) — generic GAQL mutate, dry_run default
    ├── adsense/                     # AdSense (read-only)
    │   ├── accounts_list.ex         #   List accounts
    │   ├── ad_units_list.ex         #   List ad units for an account
    │   └── reports_generate.ex      #   Generate reports
    ├── analytics/                   # GA4 Admin + Data APIs (read-only)
    │   ├── properties_list.ex       #   List properties
    │   ├── properties_get.ex        #   Get property
    │   ├── data_streams_list.ex     #   List data streams
    │   └── run_report.ex            #   Run a data report
    └── search_console/              # Search Console (sites/sitemaps manage = gated writes)
        ├── sites_list.ex            #   List verified sites
        ├── sites_get.ex             #   Get site
        ├── sites_add.ex             #   Write (gated) — add site
        ├── sites_delete.ex          #   Write (gated) — remove site
        ├── sitemaps_list.ex         #   List sitemaps
        ├── sitemaps_submit.ex       #   Write (gated) — submit sitemap
        ├── sitemaps_delete.ex       #   Write (gated) — delete sitemap
        └── search_analytics_query.ex #  Query search analytics
```

Conventions:

- One module per tool file; module name mirrors path (`Noizu.Google.MCP.Tools.Ads.ListCampaigns`).
- New tools: add module under the product namespace, register in `mcp.ex` dispatch.
- Read tools are granted by default; anything mutating must route through `writes.ex` gate.
