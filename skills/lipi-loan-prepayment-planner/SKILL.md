---
name: lipi-loan-prepayment-planner
description: Work out what prepaying a bank loan in Lipi would save in interest, months or EMI, for a one-off or a monthly extra payment, using the loan's real schedule. Compares loans to say which to pay down first. Use when the user asks whether to prepay or close a loan early, how much they'd save, or which loan to clear first. Needs the Lipi MCP server; bank loans need Lipi Premium.
---

# Loan prepayment planner

This skill runs what-ifs on the bank's schedule that Lipi stores. It shows the
same loan with and without an extra payment, side by side.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
If a loan tool answers that loans need Premium, tell the user and stop. Read
only is enough. This skill changes nothing.

## Read the loan

1. `list_bank_loans`, then `get_bank_loan` for each loan the user means.
2. From the schedule, take: outstanding balance after the last paid row, the
   current rate, the EMI, the rows left, and the interest method (reducing or
   flat).
3. Ask about the bank's rules if the user knows them: a prepayment fee, a
   minimum prepayment amount, and whether the bank lowers the EMI or shortens
   the term after a prepayment. If the user doesn't know, work out both cases.

## Work it out

For a reducing-balance loan, month by month: interest = balance × annual rate
÷ 12, principal = EMI − interest, new balance = balance − principal. A one-off
prepayment comes off the balance in the month it is paid. A monthly extra
comes off every month.

- Shorter term: keep the EMI and count the months until the balance
  reaches zero.
- Lower EMI: keep the months left and find the EMI that clears the new
  balance in that time.

Total interest is the sum of the interest column. Saving = interest on the
current schedule − interest on the new one − any prepayment fee.

For a flat-rate loan, interest is fixed on the original principal, so
prepaying may save much less. Say so, and use the bank's own figure if the
user has one.

Check your baseline against the stored schedule. If your interest for the next
few rows doesn't match the bank's rows, the bank uses a different method.
Say so, and treat your figures as estimates.

## Answer with

A small table: current plan against each option. Show months left, EMI, total
interest still to pay, interest saved, and the new end date. For several
loans, rank them by interest rate. Each spare unit of money saves the most on
the highest rate.

You can say what prepaying saves. Whether to prepay, invest or keep cash is the
user's call, so don't advise on it. Mention keeping an emergency fund. If they go ahead, the `lipi-loan-schedule` skill records it with the
bank's new schedule.
