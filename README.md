# Lipi plugins

Listing packages for AI app directories. Each one points at the same remote
MCP server, `https://api.lipi.com.np/mcp` (OAuth 2.1 with dynamic client
registration). The server itself lives in `LipiTechnology/api.lipi.com.np`.
This repo only holds what each directory asks for: listing copy, review test
cases, icons.

Nothing here is secret. Reviewer credentials go into each portal's own form,
never into this repo.

| Folder | Platform | Status |
|---|---|---|
| `chatgpt/` | OpenAI plugins (Agent Plugins format: `plugin.json`, `mcp.json`, `assets/`) | Submitted for review 2026-10-21, version 1.0.1 |
| `claude/` | Claude Code plugin `lipi-expense-tracker` (`.claude-plugin/plugin.json`, `.mcp.json`), listed by the marketplace in `.claude-plugin/marketplace.json` at the repo root | Version 1.0.0, installable from this repo |

## Use Lipi in Claude Code

```
/plugin marketplace add LipiTechnology/lipi-plugins
/plugin install lipi-expense-tracker@lipi
```

Or in one step (Claude Code 2.1.275 or later):

```
/plugin install lipi-expense-tracker --marketplace LipiTechnology/lipi-plugins
```

Then run `/mcp`, pick **lipi**, and sign in to Lipi. Choose Read only or
Full access on Lipi's consent screen.

## Use Lipi in other apps

Any app that takes a remote MCP server with OAuth needs only the URL
`https://api.lipi.com.np/mcp`. In claude.ai: Customize → Connectors → **Add
custom connector**. In ChatGPT: Settings → Apps → developer mode → **Create
app**.

The Claude directory lists the server itself as a connector, submitted at
`claude.ai/directory/manage` (paid plan needed). Submitting the
`claude/` plugin there as well needs this repo to be public and a licence.

Check the plugin before a release:

```sh
claude plugin validate ./claude                       # Claude Code
claude plugin validate ./claude --profile directory   # Anthropic's directory rules
claude plugin validate .                              # the marketplace
```

## Build a ZIP

```sh
scripts/zip.sh chatgpt   # → dist/lipi-chatgpt-plugin.zip
```

Upload it at `platform.openai.com/plugins`: **Upload plugin to make changes**
on the existing Lipi plugin. Raise `version` in `plugin.json` with every
upload.

## Known portal limits (ChatGPT)

Found by trial; the portal reports one error per upload.

- `interface.shortDescription` (shown as the subtitle) and each translated
  `subtitle`: at most 30 characters.
- `review.test_cases.positive[].tools_triggered`: a string, not a list.
- The description must not mention pricing, plans or promotions.
- No tool may switch between operations through an argument (a `method` or
  `kind` enum): the tool scan wants one tool per operation.

## Copy rules

Lipi is listed as a general personal-finance app, not a Nepal-only one: no
NPR, Nepal or NEPSE in listing copy or test prompts.
