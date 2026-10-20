---
name: lipi-savings-goal-plan
description: Turn a savings goal (an amount by a date, such as a trip, a deposit or an emergency fund) into a monthly plan from the user's real income and spending in Lipi, showing what they can save now, the gap, and which spending to trim to close it. Use when the user wants to save for something, asks how long a goal will take, or how much to put aside each month. Needs the Lipi MCP server.
---

# Savings goal plan

This skill turns a goal into a plan the user can follow, such as "Put aside
18,000 a month and spend 6,000 less on eating out", from their own numbers.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Read only is enough.

Get the goal: what it's for, the amount, the date, and how much is already
saved towards it. For an emergency fund with no amount, suggest three to six
months of essential and unavoidable spending, and work that figure out in the
next step.

## Read the numbers

1. `get_overview`: today, default currency, accounts.
2. The last 3 to 6 full months: `get_transaction_summary` for income and
   spending each month, and `get_spending_by_intent` for the split between
   essential, unavoidable, avoidable and goodwill.
3. `get_savings_rate` if the plan has insights (skip it on a Premium-only
   error).
4. Known costs ahead: `list_recurring`, `list_scheduled`, and EMIs from
   `list_bank_loans`.

## Work it out

- Needed per month = (goal − already saved) ÷ months until the date.
- Can save now = median monthly income − median monthly spending −
  excluded outflows that will keep happening (such as insurance premiums).
- Gap = needed − can save now.

If there's a gap, look at the avoidable categories, largest first. Show how
much each would have to drop to close it. Don't touch essential or unavoidable
spending unless the user asks. If the gap can't close, give the date the goal
becomes reachable at the current rate, or the amount reachable by the
original date.

## Answer with

- The goal, the date, and the monthly amount it needs.
- What the user saves today, and the gap.
- Two or three concrete changes with amounts, such as "Food delivery: from
  9,500 to 5,000 a month".
- When to check progress.

Offer, with the user's agreement: a recurring transfer into a savings account
with `create_recurring`, and lower budgets on the trimmed categories with
`create_budget` or `update_budget`. No investment advice.
