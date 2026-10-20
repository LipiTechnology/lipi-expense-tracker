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

The Claude directory takes a remote MCP server as a connector through
`claude.ai/directory/manage`, with no package: nothing to keep here unless we
later publish a Claude plugin bundle, which must come from a public GitHub repo.

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
