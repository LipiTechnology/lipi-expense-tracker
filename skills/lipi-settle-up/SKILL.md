---
name: lipi-settle-up
description: Work out who owes whom across the user's shared bills and people ledgers in Lipi, find the fewest payments that settle everything, and draft a friendly reminder message for each person. Use when the user asks who owes them, how to settle up after a trip or shared flat, or wants to remind someone about money. Needs the Lipi MCP server; recording settlements needs Full access.
---

# Settle up

This skill gives one list of who pays whom across shared bills and loans to
friends, with as few payments as possible, and words the user can send.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Read only is enough to work it out. Recording settlements needs Full access.

## Gather

1. `get_overview` for the default currency.
2. Shared bills: `get_splits_summary`, then `list_splits` and `get_split` for
   the ones with open balances, to get each member's share and what's paid.
3. People ledgers: `list_ledgers`, then `get_ledger` for each open one. Use the
   balance with any interest the ledger adds.
4. Ask whether to keep the trip or flat splits apart from personal loans. The
   default is to keep them apart, because people settle those differently.

## Work it out

Net each person: what they owe the user minus what the user owes them, per
currency. Keep currencies apart unless everyone agrees on a rate.

For a group split where members owe each other too, settle with the fewest
transfers. Pay the biggest debtor to the biggest creditor first, then
repeat until everyone is at zero. Show the result as "A pays B 2,400".

## Answer with

- A table per currency: person, owes you, you owe, net.
- The list of payments that settles it.
- For each person who owes the user, a short message the user can send. Make it
  friendly, give the amount and what it's for, and don't add guilt or
  pressure. Ask for the tone if the user cares, such as casual for friends or
  formal for a landlord.

When money changes hands, record it after the user says yes:
`record_split_settlement` for a split, `save_ledger_entry` for a ledger. The
direction is from the user's side: `in` means the user got the money.
