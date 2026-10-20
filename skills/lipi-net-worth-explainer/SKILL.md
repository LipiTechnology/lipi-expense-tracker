---
name: lipi-net-worth-explainer
description: Explain why the user's net worth in Lipi changed between two dates by splitting the change into money saved, debt paid off, asset values moving, and exchange rates moving on foreign-currency balances. Use when the user asks why their net worth went up or down, whether they are really getting richer, or how much a currency move affected them. Needs the Lipi MCP server.
---

# Net worth explainer

A net worth line can rise while the user saves nothing, because a foreign
currency got stronger or gold went up. This skill separates what the user did
from what the market did.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Read only is enough. Net worth trend and assets need Lipi Premium. On a
Premium-only error, say which part you can't show.

Use the two dates the user names, or the start of this month and today.

## Gather

1. `get_overview`: default currency, accounts with currencies.
2. `get_net_worth_trend` for the total on each date.
3. For each account, its balance on both dates in its own currency. Use
   `get_account_balance_trend`, or the opening balance plus transactions from
   `list_transactions`.
4. The rate for each foreign currency on both dates: `get_exchange_rates` with
   each date. Never use today's rate for the earlier date.
5. Assets: `list_assets` and `get_asset_summary` for value on both dates. For
   gold and silver, the price on each date (`get_metal_prices`).
6. Loans: outstanding balance on both dates from `get_bank_loan`.

## Split the change

For each foreign-currency account:
- Rate effect = balance at the start × (end rate − start rate).
- Own effect = (end balance − start balance) × end rate.

Together they make that account's change in the default currency.

Then add up:
- Saved: own effect across all accounts.
- Debt paid down: drop in loan balances.
- Assets: change in asset values. Split metals into price change and
  weight added.
- Rates: the sum of the rate effects.

Check the parts add up to the total change from step 2. If they don't, give
the difference and the likely reason, such as an asset with no valuation on
one date.

## Answer with

One line: net worth went from X to Y. Then a short table of the four parts,
with the amount and share of each. Then one sentence on what the user can
take credit for (saved and debt paid) and what came from the market (rates
and asset prices).

Give no investment or currency advice.
