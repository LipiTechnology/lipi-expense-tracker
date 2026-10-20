---
name: lipi-loan-schedule
description: Put a bank loan's real repayment (EMI) schedule into Lipi from a photo, PDF or bank letter, record prepayments and rate changes, and mark EMIs paid. Use when the user shares a loan schedule or statement, asks to add or update a loan, or says they paid an EMI. Needs the Lipi MCP server connected with Full access; bank loans need Lipi Premium.
---

# Bank loan schedules in Lipi

Lipi stores a loan's schedule row by row, exactly as the bank gives it, and
never recalculates it: banks often don't follow the textbook formula. Your job
is to copy the bank's figures faithfully.

## Before you start

This skill needs the Lipi MCP server (`https://api.lipi.com.np/mcp`) connected
with Full access. If `save_bank_loan` is missing, the connection is
read-only or not set up: say so and point the user to Lipi Settings → AI
assistants. If a tool answers that loans need Premium, tell the user and stop.

## A schedule photo or PDF

1. Read every row: instalment number (seq), due date, EMI, interest, principal,
   balance after, and rate if shown. Read it yourself or with `read_document`.
   Copy the numbers exactly; don't round or fix them.
2. `list_bank_loans`: is this loan already in Lipi?
   - No: `save_bank_loan` with the terms printed on the schedule (lender,
     principal, rate, tenure, first due date, currency). It starts with an
     estimated schedule.
3. `set_bank_loan_rows` with the rows as `actual`. Use `mode: replace` when the
   document is the bank's whole new schedule, `merge` for one page of it.
4. EMIs the user has already paid: `pay_bank_loan_rows` with their seqs. Leave
   out `book` unless those payments are not in their books yet.
5. Tell the user what changed: rows written, next EMI and its date, balance.

## A prepayment, foreclosure or rate change

`save_bank_loan_event` for the event, then write the bank's new rows with
`set_bank_loan_rows`. Use the bank's figures, not your own projection.

## Paying this month's EMI

`pay_bank_loan_rows` with `book: true` marks the row paid and records the
expense from the loan's paying account. Check with the user which row first.

Show the user what you will write before any bulk change, and ask before
deleting a loan or an event.
