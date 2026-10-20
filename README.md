# Lipi Expense Tracker

Use [Lipi](https://lipi.com.np), the personal finance app, from your AI
assistant: ask about your spending, budgets, accounts and loans, and keep your
books up to date without opening the app.

Two parts, and they work in any assistant that supports them:

- **The Lipi MCP server**, `https://api.lipi.com.np/mcp`. This is what reads
  and writes your books. You sign in to Lipi (OAuth) and choose **Read only**
  (the default) or **Full access**. You can see every action and disconnect at
  any time in Lipi under Settings → AI assistants.
- **Skills** in `skills/`, plain `SKILL.md` files in the Agent Skills format.
  They teach the assistant Lipi's workflows. They are optional, and do nothing
  without the server.

| Skill | Use it to |
|---|---|
| `lipi-monthly-review` | Review a month: totals by bucket, biggest categories, budgets, unusual spending, bills and EMIs due, three suggestions |
| `lipi-log-expenses` | Add expenses, income and transfers from what you say, a receipt or a statement, with a duplicate check first (Full access) |
| `lipi-loan-schedule` | Put a bank loan's real EMI schedule in from a photo or PDF, record prepayments, mark EMIs paid (Full access, Premium) |

You need a Lipi account at [app.lipi.com.np](https://app.lipi.com.np).

## Claude Code

The plugin bundles the server and the skills. Two commands inside Claude Code,
one at a time. First add this repo as a marketplace:

```
/plugin marketplace add LipiTechnology/lipi-expense-tracker
```

Then install the plugin:

```
/plugin install lipi-expense-tracker@lipi
```

Then run `/mcp`, pick **lipi** and sign in. Skills are called as
`/lipi-expense-tracker:lipi-monthly-review` and so on, or Claude picks them up
when they fit.

To try a local checkout without installing: `claude --plugin-dir /path/to/lipi-expense-tracker`.

## Claude (claude.ai, desktop, mobile) and ChatGPT

These take the server only:

- **Claude:** Customize → Connectors → **Add custom connector**, URL
  `https://api.lipi.com.np/mcp`, then **Connect**.
- **ChatGPT:** Settings → Apps → turn on developer mode → **Create app**, URL
  `https://api.lipi.com.np/mcp`, authentication OAuth.

## Other agents

**1. Add the server.** Every agent below then opens a browser to sign in to
Lipi the first time it connects.

| Agent | Where | Add |
|---|---|---|
| Codex | `~/.codex/config.toml` | `[mcp_servers.lipi]` with `url = "https://api.lipi.com.np/mcp"`, then run `codex mcp login lipi` |
| Cursor | `.cursor/mcp.json` or `~/.cursor/mcp.json` | `{ "mcpServers": { "lipi": { "url": "https://api.lipi.com.np/mcp" } } }` |
| VS Code (GitHub Copilot) | `.vscode/mcp.json` | `{ "servers": { "lipi": { "type": "http", "url": "https://api.lipi.com.np/mcp" } } }` |
| Gemini CLI | `~/.gemini/settings.json` | `{ "mcpServers": { "lipi": { "httpUrl": "https://api.lipi.com.np/mcp" } } }` |
| OpenCode | `opencode.json` | `{ "mcp": { "lipi": { "type": "remote", "url": "https://api.lipi.com.np/mcp" } } }` |
| Windsurf | `~/.codeium/windsurf/mcp_config.json` | `{ "mcpServers": { "lipi": { "serverUrl": "https://api.lipi.com.np/mcp" } } }` |

Any other MCP client: add a remote (Streamable HTTP) server at
`https://api.lipi.com.np/mcp` with OAuth. It supports dynamic client
registration, so there is no client ID to set up.

**2. Add the skills (optional).** One command detects your agents and asks
where to put them:

```sh
npx skills add LipiTechnology/lipi-expense-tracker
```

Or copy each folder under `skills/` into your agent's skills folder:

| Agent | Project folder | Personal folder |
|---|---|---|
| Codex | `.agents/skills/` | `~/.codex/skills/` |
| OpenCode | `.agents/skills/` | `~/.config/opencode/skills/` |
| Cursor | `.agents/skills/` | `~/.cursor/skills/` |
| GitHub Copilot | `.agents/skills/` | `~/.copilot/skills/` |
| Windsurf | `.windsurf/skills/` | `~/.codeium/windsurf/skills/` |
| Claude Code, without the plugin | `.claude/skills/` | `~/.claude/skills/` |

Outside Claude Code the skills have no `lipi-expense-tracker:` prefix; call
them by name, such as `lipi-monthly-review`.

## Privacy

Nothing in this repo is secret and nothing here collects data. What the
assistant reads from Lipi goes to that assistant's provider, under your
agreement with them. Lipi keeps a 30-day log of each action an assistant takes.
See the [privacy policy](https://lipi.com.np/privacy-policy).

## For maintainers

| Path | What |
|---|---|
| `.claude-plugin/plugin.json`, `.mcp.json`, `skills/`, `assets/` | Claude Code plugin `lipi-expense-tracker`; the repo root is the plugin |
| `.claude-plugin/marketplace.json` | Marketplace `lipi`, listing the root as the plugin |
| `chatgpt/` | OpenAI plugin package (Agent Plugins format). Submitted for review 2026-10-21, version 1.0.1 |
| `scripts/zip.sh` | Builds an upload ZIP for a platform folder |

Reviewer credentials go into each portal's own form, never into this repo.

Before a release:

```sh
claude plugin validate .                         # plugin and marketplace
claude plugin validate . --profile directory     # Anthropic's directory rules
scripts/zip.sh chatgpt                           # → dist/lipi-chatgpt-plugin.zip
```

Upload the ChatGPT ZIP at `platform.openai.com/plugins` with **Upload plugin to
make changes**, and raise `version` in `chatgpt/plugin.json` each time. Raise
`version` in `.claude-plugin/plugin.json` for each Claude Code release.

Known OpenAI portal limits, found by trial (it reports one error per upload):

- `interface.shortDescription` (the subtitle) and each translated `subtitle`:
  at most 30 characters.
- `review.test_cases.positive[].tools_triggered`: a string, not a list.
- No pricing, plans or promotions in the description.
- No tool may switch between operations through an argument (a `method` or
  `kind` enum): the scan wants one tool per operation.

Listing copy treats Lipi as a general personal finance app: no country, local
currency or local market in listing copy or test prompts.
