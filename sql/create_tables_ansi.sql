-- Halden Trade Supply: table definitions in plain ANSI-style SQL.
-- Works with minor tweaks on SQL Server, PostgreSQL, MySQL and others.
-- Load the CSVs with your database's bulk-load tool (BULK INSERT, COPY, LOAD DATA).
-- For the quickest route, use scripts/quickstart.py, which loads everything into DuckDB.

CREATE TABLE branches (branch_id INT PRIMARY KEY, branch_name VARCHAR(50), town VARCHAR(50), postcode_area VARCHAR(4), region VARCHAR(20), opened_year INT, uses_crm BOOLEAN);
CREATE TABLE staff (staff_id INT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), role VARCHAR(60), department VARCHAR(40), branch_id INT, start_date DATE);
CREATE TABLE suppliers (supplier_id INT PRIMARY KEY, supplier_name VARCHAR(120), payment_terms_days INT, edi_enabled BOOLEAN);
CREATE TABLE products (sku VARCHAR(12) PRIMARY KEY, description VARCHAR(200), category VARCHAR(50), subcategory VARCHAR(50), brand VARCHAR(50), unit_of_measure VARCHAR(20), list_price DECIMAL(12,2), cost_price DECIMAL(12,2), supplier_id INT, status VARCHAR(20));
CREATE TABLE customers (customer_id INT PRIMARY KEY, account_no VARCHAR(10), customer_name VARCHAR(150), trade_type VARCHAR(50), home_branch_id INT, postcode VARCHAR(10), account_opened DATE, credit_limit DECIMAL(12,2), payment_terms VARCHAR(20), status VARCHAR(20));
CREATE TABLE sales_orders (order_id INT PRIMARY KEY, order_no VARCHAR(12), customer_id INT, branch_id INT, channel VARCHAR(20), order_date DATE, fulfilment VARCHAR(20), taken_by_staff_id INT, status VARCHAR(20));
CREATE TABLE sales_order_lines (order_id INT, line_no INT, sku VARCHAR(12), quantity INT, list_price DECIMAL(12,2), discount_pct DECIMAL(5,3), unit_cost DECIMAL(12,2), unit_price DECIMAL(12,2), line_net DECIMAL(14,2), PRIMARY KEY (order_id, line_no));
CREATE TABLE invoices (invoice_id INT PRIMARY KEY, invoice_no VARCHAR(12), order_id INT, customer_id INT, branch_id INT, invoice_date DATE, due_date DATE, paid_date DATE, net_amount DECIMAL(14,2), vat_amount DECIMAL(14,2), gross_amount DECIMAL(14,2));
CREATE TABLE credit_notes (credit_note_id INT PRIMARY KEY, credit_note_no VARCHAR(12), invoice_id INT, customer_id INT, credit_date DATE, reason VARCHAR(50), net_amount DECIMAL(14,2), vat_amount DECIMAL(14,2));
CREATE TABLE stock_levels (branch_id INT, sku VARCHAR(12), qty_on_hand INT, reorder_point INT, snapshot_date DATE);
CREATE TABLE supplier_invoices (supplier_invoice_id INT PRIMARY KEY, supplier_id INT, supplier_invoice_ref VARCHAR(20), invoice_date DATE, received_date DATE, receipt_method VARCHAR(20), keyed_date DATE, keyed_by_staff_id INT, net_amount DECIMAL(14,2), vat_amount DECIMAL(14,2), po_number VARCHAR(12), po_amount DECIMAL(14,2), matched_to_po BOOLEAN, queries_raised INT, processing_minutes INT, status VARCHAR(20));
CREATE TABLE quotes (quote_id INT PRIMARY KEY, quote_no VARCHAR(10), customer_id INT, branch_id INT, requested_date DATE, sent_date DATE, turnaround_working_days INT, quote_value_net DECIMAL(14,2), line_count INT, prepared_by VARCHAR(30), prep_minutes INT, status VARCHAR(20), lost_reason VARCHAR(30), converted_order_no VARCHAR(12));
CREATE TABLE dc_stock_counts (sku VARCHAR(12), qty_counted INT, location VARCHAR(12), count_date DATE);
CREATE TABLE web_catalogue (web_code VARCHAR(20), web_title VARCHAR(200), category VARCHAR(50), web_price_inc_vat DECIMAL(12,2));
CREATE TABLE crm_accounts (crm_account_id VARCHAR(10) PRIMARY KEY, account_name VARCHAR(150), erp_account_no VARCHAR(10), industry VARCHAR(50), postcode VARCHAR(10), phone VARCHAR(20), owner_staff_id INT, created_date DATE, source VARCHAR(30));
CREATE TABLE crm_contacts (contact_id VARCHAR(12) PRIMARY KEY, crm_account_id VARCHAR(10), first_name VARCHAR(50), last_name VARCHAR(50), job_title VARCHAR(50), email VARCHAR(150), mobile VARCHAR(20), last_activity_date DATE, email_bounced BOOLEAN, marketing_consent VARCHAR(10));
CREATE TABLE crm_activities (activity_id INT PRIMARY KEY, crm_account_id VARCHAR(10), activity_type VARCHAR(20), activity_date DATE, logged_by_staff_id INT, notes VARCHAR(200));
CREATE TABLE marketing_campaigns (campaign_id INT PRIMARY KEY, month VARCHAR(7), channel VARCHAR(20), campaign_name VARCHAR(60), spend DECIMAL(12,2));
CREATE TABLE marketing_enquiries (enquiry_id INT PRIMARY KEY, enquiry_date DATE, campaign_id INT, source_channel VARCHAR(20), enquiry_type VARCHAR(40), postcode_area VARCHAR(4), became_account BOOLEAN);
CREATE TABLE ai_usage_log (timestamp TIMESTAMP, use_case VARCHAR(60), model VARCHAR(60), input_tokens INT, output_tokens INT, cost_gbp DECIMAL(10,4), latency_ms INT, user_staff_id INT, outcome VARCHAR(60));
