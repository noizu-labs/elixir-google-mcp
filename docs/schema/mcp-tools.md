# MCP Tool Contracts — noizu_google_mcp

All 19 tools registered in `lib/noizu/google/mcp.ex`. Input fields from each module's `input do … field/4` block.
Server name: `noizu_google` (v0.1.1), stdio transport only.

**Gating**: tools marked **W** are write tools — listed/callable only with `GOOGLE_MCP_WRITES=1` (`writes.ex`).
Ads writes (†) additionally default `dry_run=true`; live applies need `dry_run=false` + `confirm=true`.

## SearchConsole (8 tools)

### SearchConsole.SitesList *(read)*
No inputs.

### SearchConsole.SitesGet *(read)*
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| site_url | string | yes | Site URL |

### SearchConsole.SitesAdd **W**
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| site_url | string | yes | e.g. `https://example.com/` |

### SearchConsole.SitesDelete **W**
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| site_url | string | yes | Site to remove |
| confirm | boolean | yes | Must be true |

### SearchConsole.SearchAnalyticsQuery *(read)*
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| site_url | string | yes | |
| start_date | string | yes | `YYYY-MM-DD` |
| end_date | string | yes | `YYYY-MM-DD` |
| dimensions | string | no | Comma-separated |
| row_limit | integer | no | Default 25 |

### SearchConsole.SitemapsList *(read)*
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| site_url | string | yes | |

### SearchConsole.SitemapsSubmit **W**
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| site_url | string | yes | |
| feedpath | string | yes | Sitemap URL |

### SearchConsole.SitemapsDelete **W**
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| site_url | string | yes | |
| feedpath | string | yes | |

## Analytics (4 tools — GA4, all read-only)

### Analytics.PropertiesList
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| filter | string | no | |

### Analytics.PropertiesGet
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| property | string | yes | |

### Analytics.DataStreamsList
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| property | string | yes | |

### Analytics.RunReport
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| property | string | yes | Id or `properties/{id}` |
| start_date | string | yes | Date or relative (`7daysAgo`) |
| end_date | string | yes | Date or relative (`yesterday`) |
| metrics | string | yes | Comma-separated names |
| dimensions | string | no | Comma-separated names |

## AdSense (3 tools — all read-only)

### AdSense.AccountsList
No inputs.

### AdSense.AdUnitsList
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| parent | string | yes | Account ref |

### AdSense.ReportsGenerate
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| account | string | yes | `accounts/pub-…` or `pub-…` |
| start_date | string | yes | `YYYY-MM-DD` |
| end_date | string | yes | `YYYY-MM-DD` |
| metrics | string | yes | Comma-separated |
| dimensions | string | no | Comma-separated |
| currency_code | string | no | e.g. `USD` |
| limit | integer | no | |

## Ads (4 tools; needs developer token + login customer id)

### Ads.ListCampaigns *(read)*
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| customer_id | string | yes | |
| limit | integer | no | Default 50 |
| developer_token | string | no | Override |
| login_customer_id | string | no | MCC id |

### Ads.ListConversionActions *(read)*
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| customer_id | string | yes | |
| developer_token | string | no | |
| login_customer_id | string | no | |

### Ads.CreateConversionAction **W**† *(destructive_hint)*
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| customer_id | string | yes | |
| name | string | yes | |
| type | string | no | Default `WEBPAGE` |
| category | string | no | Default `DEFAULT` |
| status | string | no | Default `ENABLED` |
| dry_run | boolean | no | Default true (validateOnly) |
| confirm | boolean | no | Required true for live create |
| developer_token / login_customer_id | string | no | Overrides |

### Ads.Mutate **W**† *(destructive_hint)*
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| customer_id | string | yes | |
| mutate_operations_json | string | yes | JSON array of MutateOperation objects |
| dry_run | boolean | no | Default true (validateOnly) |
| confirm | boolean | no | Required true when `dry_run=false` |
| developer_token | string | no | Override |
| login_customer_id | string | no | MCC id |
