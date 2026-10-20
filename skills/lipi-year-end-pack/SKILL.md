---
name: lipi-year-end-pack
description: Put together a year-end summary from the user's Lipi books for filing taxes or handing to an accountant: income by source, tax already paid, insurance, investments and loan interest, invoices issued and paid, and a CSV of the year, with a list of what's missing. Use when the user asks for a tax summary, a yearly summary for their accountant, or what they earned and paid in a financial year. Needs the Lipi MCP server.
---

# Year-end pack

Tax rules differ by country, and this skill doesn't apply them. It gathers the
figures any accountant asks for from the user's own books, and points out the
gaps before the accountant does.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
Read only is enough.

Ask for the financial year's start and end dates. Years don't start in
January everywhere. Ask which country the user files in, only so you can name
the usual documents. Don't work out tax owed.

## Gather

1. `get_overview` for the default currency and accounts.
2. `get_transaction_summary` for the year: income, spending, excluded and tax.
3. `list_transactions` for the year:
   - Income, grouped by category or payer (salary, freelance, rent, interest).
   - Tax bucket: tax already paid or withheld, with dates.
   - Excluded bucket: insurance premiums, investments and savings moves.
     Many countries treat these differently from spending.
4. Loans: `list_bank_loans` and `get_bank_loan`. Sum the interest and
   principal of the EMIs paid inside the year.
5. Invoices, if the user has them: `list_invoices` for the year, issued against
   paid.
6. `export_transactions_csv` for the year, if the plan allows (skip it on a
   Premium-only error).

## Answer with

- A one-page summary: income by source, tax paid, insurance, investments, loan
  interest and principal, invoices issued and paid. Keep each currency apart,
  and give totals in the default currency.
- Missing or doubtful: months with no salary, tax with no matching income,
  insurance premiums booked as spending, large uncategorized amounts. The
  `lipi-books-cleanup` skill can fix these first.
- The usual documents to collect for their country, as a checklist: salary and
  tax certificates, insurance receipts, loan interest letters. Mark that they
  should confirm it with their accountant or tax office.
- The CSV, or the steps to export it from the Lipi app.

State that this is a summary of the user's records, not tax advice.
