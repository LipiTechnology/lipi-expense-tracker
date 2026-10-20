---
name: lipi-invoice-follow-up
description: Find the user's unpaid and overdue invoices in Lipi, group them by how late they are, and draft a follow-up email for each client in a tone that fits the lateness. Records payments when they arrive. Use when the user asks who hasn't paid, wants to chase invoices, or says a client paid. Needs the Lipi MCP server; invoices need Lipi Premium.
---

# Invoice follow-up

This skill shows who owes what and how late, and writes each follow-up email
so the user only has to read and send it.

## Before you start

Needs the Lipi MCP server (`https://api.lipi.com.np/mcp`). Without its tools,
say so and point to https://github.com/LipiTechnology/lipi-expense-tracker#readme.
If an invoice tool answers that invoices need Premium, tell the user and stop.

## Gather

1. `get_overview` for today's date.
2. `list_invoices`, every page. Keep the ones sent and not fully paid.
3. `get_invoice` for each: number, client, issue and due dates, total, amount
   paid, currency. `list_clients` for client names and emails.

## Sort

Days late = today − due date.

- Not due yet: no action. List them.
- 1 to 14 days late: a friendly reminder.
- 15 to 45 days late: a firm reminder that asks for a payment date.
- Over 45 days late: a final, formal notice. Suggest the user calls the
  client too.

## Draft

One email per client, covering all of that client's open invoices. Each email
has a subject line, the invoice numbers, amounts and due dates, the total
outstanding, and how to pay if the user tells you. Match the tone to the most
late invoice. Write in the user's name. Never threaten legal action or
late fees unless the user says their terms include them.

## Answer with

A table: client, invoices, outstanding, days late, stage. Then the drafts, ready
to copy. You can't send email. The user sends it.

When the user says a client paid: `record_invoice_payment` with the amount and
date, after they confirm. Mark an invoice paid or void with
`set_invoice_status` only if they ask.
