---
name: lipi-budget-builder
description: Build a realistic set of Lipi budgets from the user's own spending history, with one limit per category based on what they really spend and adjusted for a savings target. Creates them once the user agrees. Use when the user wants to start budgeting, asks how much they should budget, says their budgets keep breaking, or wants to save a set amount each month. Needs the Lipi MCP server; creating budgets needs Full access.
---

# Budget builder

This skill starts each budget from what the user actually spends, then trims
where the user says they can.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Reading works with Read only. Creating budgets needs Full access.

Ask two things if the user hasn't said them:
- Monthly take-home income, or let you read it from Lipi.
- A savings target per month, as an amount or a share of income.

## Read the history

1. `get_overview`: default currency, categories with ids, plan.
2. `list_budgets`: the budgets they already have, so you don't duplicate them.
3. The last 3 to 6 full months: `get_transaction_summary` and
   `get_spending_by_intent` for each month, and `list_transactions` (type
   expense, `reporting_bucket` spending) to get each category's total per month.
4. Skip months that were unusual, such as a wedding or a move, if the user
   says so.

## Propose

For each category with regular spending:

- Usual amount: the median of its monthly totals.
- Proposed limit: the usual amount, rounded up to a tidy figure.
- If income minus all limits is short of the savings target, cut first from
  categories whose intent is avoidable, then goodwill. Leave essential and
  unavoidable ones alone unless the user asks. Show where each cut comes from.

Group small, irregular categories into one "Everything else" budget rather
than a dozen tiny ones.

Show a table: category, usual monthly spend, proposed limit, change. Then the
totals: income, all limits, what is left for savings.

## Create

Only after the user agrees, and with their changes, call `create_budget` once
per budget: `scope` category with the `category_ids`, `period` monthly,
`repeat` true, `start_date` the first day of next month unless they want this
month. Then `get_budget_progress` to show they are in place.

Don't delete or change existing budgets without asking. Spending only: the
excluded and tax buckets don't belong in a spending budget.
