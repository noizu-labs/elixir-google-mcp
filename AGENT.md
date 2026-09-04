# AGENT.md — elixir-google-mcp

Guidance for coding agents (Grok, Codex, Claude, Cursor). Monorepo ops → `../../../../../CLAUDE.md` (trl-infra root).

## Identity

Elixir MCP library for Google-surface integrations (Google MCP host tooling), sibling of `ai/elixir-mcp`. Consumed by NPL/tobor MCP hosting layers.

## Stack & Commands

Elixir. `mix deps.get && mix compile`; `mix test`; `mix format`, `mix credo`.

## Universal Rules (compressed)

- **Trinity Protocol REQUIRED**: Orientation → Friction → Response (full text: monorepo `protocols/the-trinity-protocol.md`).
- **No shell in main thread** — delegate to taskers.
- **Worktrees**: all work on worktrees; `epic.<group>` consolidation branches off `develop`; squash-PR provenance into epics.
- MAIN checkout owns `deps/_build`; worktrees symlink deps (absolute path).
