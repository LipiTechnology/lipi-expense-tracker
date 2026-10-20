---
name: lipi-monthly-review
description: Review a month of the user's finances in Lipi - totals by bucket, biggest categories, budgets over or close, unusual spending, upcoming bills and EMIs - and end with three concrete suggestions. Use when the user asks how their month went, for a money review or summary, "where did my money go", or how they are doing against their budgets. Needs the Lipi MCP server connected.
---

# Lipi monthly review

Give the user a clear picture of one month of their money, from their own Lipi
books, and three things they could do about it.

## Before you start

This skill needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). If tools
such as `get_overview` are not available, say so and point the user to the
setup steps at https://github.com/LipiTechnology/lipi-expense-tracker#readme. Do not
guess figures.

The month is the one the user names, or the current month. Work in Gregorian
dates (`YYYY-MM-DD`). If the user names a month in another calendar, such as
Bikram Sambat, convert it and say which dates you used.

## Steps

1. `get_overview`: today's date, the user's default currency, accounts and plan.
2. `get_transaction_summary` from the first to the last day of the month.
   Income, spending, excluded and tax come back separately. Keep them apart:
   excluded money (insurance, investments, loan principal) and tax are not
   spending.
3. `get_spending_by_intent` for the month. Name the largest categories and how
   much of the spending was essential, unavoidable or avoidable.
4. `get_budget_progress`. Which budgets are over, which are close (above about
   80%), and how many days are left in each period.
5. If the user's plan includes insights: `get_unusual_spend` and
   `get_bills_radar`. A Premium-only error means skip this step; mention it
   once, don't retry.
6. `list_bank_loans`: the next EMI due on each active loan, if there are any.

## What to write

- One opening line: total spent this month, in the default currency, and how it
  compares with income.
- The biggest categories, with amounts.
- Budgets over or close, with how much is left.
- Anything unusual and the bills or EMIs due soon.
- Three suggestions tied to the numbers above, each something the user can do
  this month. No investment advice.

Every total says which bucket it covers. Amounts stay in their own currency,
written the way the user writes them. This skill only reads; change nothing
unless the user asks.
