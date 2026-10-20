---
name: lipi-books-cleanup
description: Tidy the user's Lipi books. Find uncategorized or likely miscategorized transactions, duplicates, transfers booked as an expense plus an income, and outflows in the wrong bucket, then fix them in one reviewed batch. Use when the user says their reports look wrong, wants to clean up or recategorize transactions, or after a big import. Needs the Lipi MCP server; fixes need Full access.
---

# Books cleanup

This skill finds the records that make reports wrong, proposes a fix for each, and applies only the
fixes the user approves.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Finding problems works with Read only. Fixing them needs Full access.

Look at the last 3 months unless the user wants longer.

## Find

1. `get_overview`: accounts, categories with ids and intents.
2. `list_transactions` over the window, every page.
3. Look for:
   - No category.
   - Odd category: the same payee or description is filed under one
     category most of the time and somewhere else now and then. Propose the
     usual one.
   - Duplicates: same account, same amount, same or next day, similar
     description. Mention that both could be real, such as two coffees.
   - Hidden transfers: an expense on one of the user's accounts and an
     income of the same amount on another, within two days. That's one
     transfer, not spending.
   - Wrong bucket: insurance premiums, investments, savings moves or loan
     principal booked as spending, which belong in excluded; income tax or TDS
     booked as spending, which belongs in tax.
   - Wrong intent: a category whose intent doesn't fit, such as rent marked
     avoidable.

## Review

Show the findings grouped by type, each with date, account, amount,
description, the problem and the fix. Number them so the user can say "do all
but 4 and 7". Change nothing until they answer.

## Fix

- Category, bucket or intent: `update_transaction` with only the fields that
  change.
- Hidden transfer: create it with `create_transfer`, then delete the two
  original records with `delete_transaction`, after a separate yes for the
  deletes.
- Duplicate: `delete_transaction` on the one the user picks.
- Category intent: `update_category`.

Afterwards, show how this month's spending total changed because of the fixes.
