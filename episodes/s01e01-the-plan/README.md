# S01E01 · The Plan

Halden's new owners want AI. Before anyone spends a penny, three questions: what was revenue last year, how many customers do we have, and what does a quote cost us?

**Free here:** `starter.sql` puts Halden's two revenue reports side by side, so you can see the £5.5m gap for yourself.

```bash
python scripts/quickstart.py
duckdb halden.duckdb < episodes/s01e01-the-plan/starter.sql
```

(No DuckDB command line? Run the query from Python: `duckdb.connect("halden.duckdb").sql(open("episodes/s01e01-the-plan/starter.sql").read()).show()`.)

**For paid subscribers:** the full revenue reconciliation, the CRM-to-ERP matching walkthrough, the quote speed notebook and the AI-Readiness Scorecard. Linked from the episode on [The AI Casebook](https://theaicasebook.substack.com).
