---
name: lipi-log-expenses
description: Record expenses, income and transfers in Lipi from what the user says, a receipt photo or a bank statement. Picks the right account and category, keeps transfers separate from spending, and checks for duplicates before writing. Use when the user says they spent, paid, received or moved money, or shares a receipt or statement to add. Needs the Lipi MCP server connected with Full access.
---

# Log money in Lipi

Turn what the user tells or shows you into correct Lipi records, and show them
what you will write before you write it.

## Before you start

This skill needs the Lipi MCP server (`https://api.lipi.com.np/mcp`) connected
with Full access. If tools such as `create_transaction` are missing, the
connection is read-only or not set up: say so and point the user to Lipi
Settings → AI assistants, or to
https://github.com/LipiTechnology/lipi-expense-tracker#readme. Never say a record
was saved when it wasn't.

## Steps

1. `get_overview` once: today's date, default currency, every account with its
   currency, every category with its id.
2. Work out each record:
   - Amount as a decimal string (`"1250.00"`), in the account's currency.
   - Date: the date it happened, not today, if the user or the receipt says.
   - Account: the one the user names; ask if it isn't clear.
   - Category: the closest existing one. Suggest a new category rather than
     forcing a bad fit, and create it only if the user agrees.
   - Foreign currency: pass `currency` and let Lipi use that date's rate, or
     the `exchange_rate` the user actually got.
3. Transfers are not spending. Money moving between the user's own accounts
   (bank to wallet, paying a credit card, cash withdrawal) is `create_transfer`,
   never an expense plus an income.
4. Check for duplicates with `list_transactions` over the same dates and
   account before adding a statement or a list.
5. Show the user the records (date, account, category, amount, note) and
   wait for a yes.
6. Write them:
   - One record: `create_transaction`.
   - Several: `create_transactions` once, not one call each. Set
     `source: "ocr"` when the figures came from an image.
   - A receipt photo: read it yourself or with `read_document`, or use
     `scan_receipt`; keep the image with `attach_file` if the user wants.
7. Confirm what was saved, with the new account balance if it changed.

Ask before deleting or changing existing records. If a tool returns a plan
limit or a validation error, tell the user what it says instead of retrying.
