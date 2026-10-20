---
name: lipi-spending-explainer
description: Explain why the user's spending changed between two periods in Lipi: which categories moved, and whether each moved because of more purchases, bigger purchases, a few one-off items, or a currency rate. Uses plain words and names the transactions behind it. Use when the user asks why they spent more or less this month, what changed, or where an increase came from. Needs the Lipi MCP server.
---

# Spending explainer

This skill breaks a change in spending down into its reasons, such as "Groceries
went up because you shopped twice as often, and a 15,000 laptop repair landed
in October".

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Read only is enough.

Use the two periods the user names, or this month so far against the same days
of last month. Compare equal lengths. A half month against a full one makes
every category look like it fell.

## Gather

1. `get_overview` for the default currency.
2. `get_transaction_summary` for both periods. Check the change is in spending
   and not in excluded or tax. If the change is mostly excluded (such as a yearly
   insurance premium), say that first.
3. `get_category_movers` if the plan has insights. Otherwise work the movers
   out from step 4.
4. `list_transactions` for both periods, type expense, spending bucket. Group
   by category.

## Break each mover down

For each of the three to five categories that moved most in money:

- Count: number of transactions in each period.
- Size: the median amount in each period.
- One-offs: single transactions bigger than three times that category's
  median. Name them with their date and description.
- Rate effect: for foreign-currency transactions, the rate on each date.
  Did the price stay the same in its own currency and only the conversion move?

Then say which it was: more often, bigger each time, one-offs, or the rate.

## Answer with

- One line: total change, and how much of it the top movers explain.
- One short paragraph per mover, with its reason and the transactions behind
  it.
- What's likely to repeat next month, and what was one-off.

Describe the change; don't judge it. If the user asks what to do about it,
suggest a budget with the `lipi-budget-builder` skill.
