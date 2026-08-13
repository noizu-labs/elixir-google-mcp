# Changelog

All notable changes to this project are documented in this file.
This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.1.0

- Initial release: MCP stdio server wrapping `:noizu_google`
- Search Console tools: sites (list/get/add/delete), search analytics, sitemaps
- GA4 Admin/Data tools: properties, data streams, runReport
- AdSense tools: accounts, ad units, reports
- Google Ads tools: list campaigns, list/create conversion actions, mutate
- Destructive Ads/Search Console writes require `confirm` (Ads mutates default to `dry_run`)
- Auth from `GOOGLE_*` or `GOOGLE_MARKETING_*` environment variables
