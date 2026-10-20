---
name: lipi-cash-flow-forecast
description: Project each Lipi account's balance day by day for the next 30 to 90 days from recurring items, scheduled payments, loan EMIs and the user's usual daily spending, and warn about the first day an account would run short. Use when the user asks whether they can afford something, if money will last until payday, when they will run low, or what their balance will be on a date. Needs the Lipi MCP server.
---

# Cash flow forecast

This skill works out what is coming on top of what Lipi has booked. It gives a
dated balance line for each account, and the first day it goes below zero or
below a floor the user names.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Read only is enough.

Ask for the horizon if the user didn't give one. Default to 60 days.

## Gather

1. `get_overview`: today, default currency, accounts with balances and
   currencies.
2. `list_recurring` and `list_scheduled`: everything due inside the horizon,
   with its account, amount and dates. Expand each recurring item into its
   dates in the horizon.
3. `list_bank_loans`, then `get_bank_loan` for each active loan: unpaid EMI
   rows due inside the horizon and the account that pays them.
4. Usual day-to-day spending: `list_transactions` for the last 90 days, type
   expense. Leave out anything that is already a recurring item, scheduled
   payment or EMI, so it isn't counted twice. Take the median daily spend per
   account, not the mean, so one big purchase doesn't inflate every day.
5. Income that isn't recurring yet: if the last three months show a salary on a
   similar date each month, ask the user before counting it.

## Work it out

For each account, start from today's balance and walk forward a day at a time:
add the income due that day, subtract recurring, scheduled and EMI amounts due
that day, subtract the usual daily spend.

Keep each account in its own currency. Don't convert unless the user asks for
one total. If they do, convert with `convert_currency` at today's rate and say
that future rates will differ.

## Answer with

- One line per account: balance today, lowest point and its date, balance at
  the end of the horizon.
- The first day any account goes below zero, or below the user's floor, and
  what causes it on that day.
- The three biggest known payments in the horizon.
- What would fix a shortfall: which payment to move, how much to transfer from
  which account, and by when.

Say plainly that this is a projection from past habits and booked items, not
a promise. Don't change anything in Lipi. If the user wants to book a
transfer or reschedule a payment, use the matching tool after they say yes.
