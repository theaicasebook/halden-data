"""
Halden Trade Supply - quick start
Loads every CSV into a local DuckDB database and asks a few first questions.

    python scripts/quickstart.py              # sample data
    python scripts/quickstart.py data/full    # full data, once unzipped there
"""
import os
import sys

import duckdb

DATA = sys.argv[1] if len(sys.argv) > 1 else os.path.join("data", "sample")
DB = "halden.duckdb"

con = duckdb.connect(DB)
loaded = 0
for root, _, files in os.walk(DATA):
    for f in sorted(files):
        if not f.endswith(".csv"):
            continue
        schema = os.path.basename(root)
        table = f[:-4]
        con.execute(f"CREATE SCHEMA IF NOT EXISTS {schema}")
        con.execute(f"CREATE OR REPLACE TABLE {schema}.{table} AS SELECT * FROM read_csv_auto(?, header=true, all_varchar=false)",
                    [os.path.join(root, f)])
        loaded += 1
print(f"Loaded {loaded} tables from {DATA} into {DB}\n")


def show(title, sql):
    print(f"--- {title}")
    print(con.sql(sql))


show("Revenue by year, as Finance reports it (£m)",
     "SELECT left(month, 4) AS year, round(sum(revenue)/1e6, 2) AS revenue_m FROM reports.finance_revenue_monthly GROUP BY 1 ORDER BY 1")
show("Revenue by year, as Sales reports it (£m)",
     "SELECT left(month, 4) AS year, round(sum(sales_value)/1e6, 2) AS sales_m FROM reports.sales_revenue_monthly GROUP BY 1 ORDER BY 1")
show("Orders by channel",
     "SELECT channel, count(*) AS orders FROM erp.sales_orders GROUP BY 1 ORDER BY 2 DESC")
show("How many CRM accounts can be matched to an ERP customer by account number?",
     """SELECT count(*) AS crm_accounts,
               count(c.customer_id) AS matched_by_account_no,
               round(100.0 * count(c.customer_id) / count(*), 1) AS pct_matched
        FROM crm.accounts a LEFT JOIN erp.customers c ON a.erp_account_no = c.account_no""")
print("\nTwo revenue numbers, and a CRM that can't find its own customers. Welcome to Halden.")
print("Explore further with:  duckdb halden.duckdb")
