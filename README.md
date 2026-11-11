# Halden Trade Supply: the dataset

**The company behind [The AI Casebook](https://theaicasebook.substack.com).** *AI that earns its keep: the business case for leaders, the build for engineers.*

Halden Trade Supply is a UK builders' merchant: 12 branches across the Midlands and the North, a central distribution centre, around £80m of annual revenue, about 400 staff, and roughly 8,000 trade accounts. It was a family business for 30 years until a private-equity firm bought it. The new owners want margin, and they want AI.

This repository holds Halden's data: two years of history (January 2024 to December 2025) from the systems a firm like Halden actually runs:

| System | Folder | What's in it |
|---|---|---|
| ERP | `erp/` | Branches, staff, suppliers, products, customers, sales orders and lines, invoices, credit notes, stock, supplier invoices |
| Sales | `sales/` | Quotes: when they were asked for, when they were sent, and whether they were won |
| CRM | `crm/` | Accounts, contacts and activity logged by the sales team |
| Warehouse | `wms/` | Stock counts at the distribution centre |
| Website | `web/` | The trade website's product catalogue |
| Marketing | `marketing/` | Campaign spend and the enquiries it produced |
| Spreadsheets | `spreadsheets/` | The things that live in Excel: customer rebates, branch targets |
| Reports | `reports/` | The two monthly revenue reports the board receives |
| AI | `ai/` | The AI usage log. Empty for now: Halden hasn't switched anything on yet |

> **Halden is fictional.** Every company, person, address, email address and phone number here is generated. Emails use the reserved `.example` domain, and mobile numbers use Ofcom's range reserved for drama (07700 900xxx). The problems in the data, and the numbers they're modelled on, are real.

## The data is messy on purpose

Halden's data looks like most mid-market companies' data: years of manual entry, systems that don't talk to each other, and spreadsheets filling the gaps. That's the point. Each episode of The AI Casebook finds one of those problems, works out what it costs, and fixes it.

You'll find things that don't add up. That's not a bug in the dataset. That's Halden.

## Two sizes

| | Size | Where |
|---|---|---|
| **Sample** | 10% of customers and their history (~18 MB) | `data/sample/` in this repo |
| **Full** | All of it: ~450,000 orders, 1.5m order lines (~160 MB unzipped) | Download `halden_full_v1.zip` from this repo's [Releases](../../releases) page |

The two monthly revenue reports and the branch/product/staff reference tables are company-wide in both sizes.

## Quick start

You need Python 3.10+.

```bash
pip install -r requirements.txt
python scripts/quickstart.py            # uses data/sample
python scripts/quickstart.py data/full  # once you've unzipped the full dataset there
```

`quickstart.py` loads everything into a [DuckDB](https://duckdb.org) database file (`halden.duckdb`) and runs a few first questions. DuckDB runs on your laptop with no server to install. If you prefer SQL Server, Postgres or Excel, every table is a plain CSV.

## Follow along

Each episode of The AI Casebook comes with a folder in this repository (`episodes/`) holding the free starter code. Worked solutions, templates and the full builds are for paid subscribers.

- **Read the series:** [The AI Casebook on Substack](https://theaicasebook.substack.com)
- **Start here:** Meet Halden, the cast and the season so far are linked from every episode.

## Licence

- **Code** (`scripts/`, `sql/`, `episodes/`): MIT licence. See `LICENSE`.
- **Data** (`data/`): Creative Commons Attribution 4.0 (CC BY 4.0). Use it for anything, including teaching and commercial work, as long as you credit "Halden Trade Supply dataset, The AI Casebook". See `LICENSE-DATA.md`.
