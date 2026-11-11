# S01E02 · Three Wrong Emails

Halden's new AI sales assistant emailed 16,922 people on its first morning. Nearly two in three of those emails went wrong.

**Free here:** `starter.sql` runs three of the five checks from the episode (opted out, already bounced, silent for 15+ months) on the contacts table.

```bash
python scripts/quickstart.py
duckdb halden.duckdb < episodes/s01e02-three-wrong-emails/starter.sql
```

**For paid subscribers:** the full send-list audit, the win-back list, the `sendable_contacts` guardrail view and the AI outbound pre-flight check. Linked from the episode on [The AI Casebook](https://theaicasebook.substack.com).
