---
name: lipi-subscription-audit
description: Audit the user's subscriptions and other repeating charges in Lipi. Finds ones not set up as recurring, price rises, duplicates and services they may have stopped using, and gives the yearly cost of each with what cancelling would save. Can draft cancellation messages. Use when the user asks what they pay for every month, wants to cut subscriptions, or asks why a bill went up. Needs the Lipi MCP server.
---

# Subscription audit

This skill lists every repeating charge, prices it per year, and marks the ones worth a second look.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Read only is enough to audit. Setting up recurring items needs Full access.

## Find them

1. `get_overview` for the default currency and accounts.
2. Known ones: `list_recurring`, and `get_recurring_expenses` if the user's
   plan has insights (skip it on a Premium-only error).
3. Hidden ones: `list_transactions` for the last 12 months, type expense. Group
   by payee or description. A group with three or more charges, a similar
   amount each time, and a steady gap between them (weekly, monthly, yearly) is
   a repeating charge, even if nobody set it up as recurring.

## Check each one

- Yearly cost: amount times charges per year, in the default currency.
- Price rise: compare the latest charge with the first one in the window.
  Show both amounts and the dates.
- Duplicate: two services that do the same job, such as two music or two
  video subscriptions, or one service charged on two accounts.
- Possibly unused: ask the user. You can't see usage, only payments. Never
  call a subscription unused on your own.
- Not set up as recurring: it repeats, but Lipi isn't tracking it.

## Answer with

A table: name, how often, latest amount, yearly cost, flags. Sort by yearly
cost, highest first. Then:

- The total yearly cost of all repeating charges.
- What cancelling the flagged ones would save per year.
- Ones to set up as recurring in Lipi, so forecasts and the bills radar see
  them. Offer to do it with `create_recurring`, after the user says yes.

If the user wants to cancel something, draft a short, polite cancellation
message or a list of steps for that service. Don't claim to know a service's
cancellation rules. Tell them to check the service's own help page.
