-- The AI Casebook, S01E02 "Three Wrong Emails": free starter
-- Three checks to run before any AI tool emails anyone. Needs only the contacts table.
-- Run after scripts/quickstart.py:   duckdb halden.duckdb < episodes/s01e02-three-wrong-emails/starter.sql

SELECT
  count(*)                                                        AS emailed,
  count(*) FILTER (WHERE marketing_consent = 'No')                AS opted_out,
  count(*) FILTER (WHERE marketing_consent IS DISTINCT FROM 'No'
                     AND email_bounced)                           AS already_bounced,
  count(*) FILTER (WHERE marketing_consent IS DISTINCT FROM 'No'
                     AND NOT email_bounced
                     AND last_activity_date < DATE '2026-02-02' - INTERVAL 15 MONTH)
                                                                  AS silent_15_months
FROM crm.contacts
WHERE email IS NOT NULL;

-- The other two checks (the same firm emailed several times, and customers emailed as strangers)
-- need the CRM matched to the ERP. Hint: start from the matching in Episode 1.
