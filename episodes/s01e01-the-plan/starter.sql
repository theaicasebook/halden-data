-- The AI Casebook, S01E01 "The Plan": free starter
-- Halden's two revenue reports, side by side. Every month, Sales comes out higher. Why?
-- Run after scripts/quickstart.py:   duckdb halden.duckdb < episodes/s01e01-the-plan/starter.sql

SELECT f.month,
       round(f.revenue / 1e6, 2)      AS finance_m,
       round(s.sales_value / 1e6, 2)  AS sales_m,
       round((s.sales_value - f.revenue) / 1e6, 2) AS gap_m
FROM reports.finance_revenue_monthly f
JOIN reports.sales_revenue_monthly  s USING (month)
WHERE f.month LIKE '2025-%'
ORDER BY f.month;

-- Two hints, if you want to try the rest yourself:
--   1. Compare erp.sales_orders by channel and status with what Finance invoiced (erp.invoices).
--   2. Look at the other columns in reports.finance_revenue_monthly.
