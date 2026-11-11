# Halden Trade Supply: data dictionary

All files are UTF-8 CSV with a header row. Dates are `YYYY-MM-DD`. Money is in pounds sterling. Unless stated, amounts are **net of VAT** (VAT is 20%).

History runs from **1 January 2024 to 31 December 2025**.

---

## ERP (`erp/`)

The ERP is Halden's system of record for trading: orders, invoices, stock and the customer master. It is 15 years old and heavily customised.

### `branches.csv`
| Column | Description |
|---|---|
| branch_id | Branch key. `0` is the Central DC (distribution centre) |
| branch_name | Short name used internally |
| town | Town the branch is in |
| postcode_area | Postcode area the branch serves |
| region | Midlands or North |
| opened_year | Year the branch opened |
| uses_crm | Whether the branch actually uses the CRM day to day |

### `staff.csv`
| Column | Description |
|---|---|
| staff_id | Staff key |
| first_name, last_name | Name |
| role | Job title |
| department | Department |
| branch_id | Where they're based (`0` = head office or DC) |
| start_date | Date they joined |

### `suppliers.csv`
| Column | Description |
|---|---|
| supplier_id | Supplier key |
| supplier_name | Supplier name |
| payment_terms_days | Days Halden has to pay |
| edi_enabled | Whether the supplier sends invoices electronically (EDI). Everyone else sends PDFs or paper |

### `products.csv`
| Column | Description |
|---|---|
| sku | Product code, format `HTS-nnnnnn` |
| description | Product description |
| category, subcategory | Product hierarchy |
| brand | Brand |
| unit_of_measure | Unit sold (bag, length, sheet, each…) |
| list_price | Trade list price per unit |
| cost_price | Halden's cost per unit |
| supplier_id | Main supplier |
| status | Active or Discontinued |

### `customers.csv`
Trade accounts in the ERP.
| Column | Description |
|---|---|
| customer_id | Customer key |
| account_no | ERP account number, format `Hnnnnnn` |
| customer_name | Trading name as entered on the account |
| trade_type | What the customer does |
| home_branch_id | Branch that looks after the account |
| postcode | Account address postcode |
| account_opened | Date the account was opened |
| credit_limit | Credit limit (£) |
| payment_terms | Agreed terms |
| status | Active or On Stop |

### `sales_orders.csv`
One row per order.
| Column | Description |
|---|---|
| order_id | Order key |
| order_no | Order number, format `SOnnnnnnn` |
| customer_id | Customer |
| branch_id | Branch that took the order |
| channel | Counter, Phone, Email, Web or Account Manager |
| order_date | Date the order was placed |
| fulfilment | Delivery or Collection |
| taken_by_staff_id | Account manager, where the order came through one |
| status | Invoiced or Cancelled |

### `sales_order_lines.csv`
| Column | Description |
|---|---|
| order_id, line_no | Order and line number |
| sku | Product |
| quantity | Units ordered |
| list_price | List price at the time |
| discount_pct | Trade discount given on the line |
| unit_cost | Cost per unit at the time |
| unit_price | Price charged per unit |
| line_net | `unit_price × quantity`, net of VAT |

### `invoices.csv`
One invoice per invoiced order.
| Column | Description |
|---|---|
| invoice_id, invoice_no | Invoice key and number |
| order_id, customer_id, branch_id | What was invoiced, to whom, from where |
| invoice_date, due_date, paid_date | Key dates. `paid_date` is blank if unpaid |
| net_amount, vat_amount, gross_amount | Amounts |

### `credit_notes.csv`
| Column | Description |
|---|---|
| credit_note_id, credit_note_no | Key and number |
| invoice_id, customer_id | The invoice being credited |
| credit_date | Date issued |
| reason | Why |
| net_amount, vat_amount | Amount credited |

### `stock_levels.csv`
ERP stock position at 31 December 2025.
| Column | Description |
|---|---|
| branch_id, sku | Where and what |
| qty_on_hand | Units the ERP believes are in stock |
| reorder_point | Level that triggers a reorder |
| snapshot_date | Date of the snapshot |

### `supplier_invoices.csv`
Invoices Halden receives from suppliers and keys into the ERP.
| Column | Description |
|---|---|
| supplier_invoice_id | Key |
| supplier_id, supplier_invoice_ref | Supplier and their invoice reference |
| invoice_date, received_date, keyed_date | When it was issued, received and keyed |
| receipt_method | EDI, PDF email or Paper post |
| keyed_by_staff_id | AP clerk who keyed it (blank for EDI) |
| net_amount, vat_amount | Amounts as keyed |
| po_number | Purchase order quoted on the invoice (sometimes missing) |
| po_amount | Amount on the purchase order |
| matched_to_po | Whether it matched its purchase order |
| queries_raised | Queries raised before it could be paid |
| processing_minutes | Clerk time spent on the invoice, end to end |
| status | Posted or Awaiting keying |

---

## Sales (`sales/`)

### `quotes.csv`
Quotes for larger jobs, prepared by hand by branch and internal sales staff.
| Column | Description |
|---|---|
| quote_id, quote_no | Key and number |
| customer_id, branch_id | Who asked, which branch quoted |
| requested_date, sent_date | When the customer asked, when the quote went out |
| turnaround_working_days | Working days between the two |
| quote_value_net | Value of the quote |
| line_count | Number of lines on the quote |
| prepared_by | Role of the person who built it |
| prep_minutes | Time spent preparing it |
| status | Won, Lost or No response |
| lost_reason | Reason given, where one was recorded |
| converted_order_no | The order it turned into, where it can be traced |

---

## CRM (`crm/`)

Brought in four years ago. Half the branches use it; half barely touch it.

### `accounts.csv`
| Column | Description |
|---|---|
| crm_account_id | CRM key, format `ACC-xxxxx` |
| account_name | Company name as typed into the CRM |
| erp_account_no | ERP account number, where someone filled it in |
| industry | Free-text industry field |
| postcode | Postcode, where entered |
| phone | Main number |
| owner_staff_id | Sales owner |
| created_date | When the record was created |
| source | How the record got there |

### `contacts.csv`
| Column | Description |
|---|---|
| contact_id | Key |
| crm_account_id | Account the contact belongs to |
| first_name, last_name, job_title | Who they are |
| email, mobile | How to reach them |
| last_activity_date | Last time anyone logged anything against them |
| email_bounced | Whether an email to them has bounced |
| marketing_consent | Yes, No, Unknown or blank |

### `activities.csv`
| Column | Description |
|---|---|
| activity_id | Key |
| crm_account_id | Account |
| activity_type | Call, Email, Visit, Note, Quote follow-up |
| activity_date | When |
| logged_by_staff_id | Who logged it |
| notes | Free text |

---

## Warehouse (`wms/`)

### `dc_stock_counts.csv`
Physical counts at the Central DC, from the warehouse management system.
| Column | Description |
|---|---|
| sku | Product |
| qty_counted | Units counted |
| location | Bin location |
| count_date | Date counted |

---

## Website (`web/`)

### `web_catalogue.csv`
The trade website's product listings.
| Column | Description |
|---|---|
| web_code | Product code used by the website |
| web_title | Title shown on the website |
| category | Category |
| web_price_inc_vat | Price shown, including VAT |

---

## Marketing (`marketing/`)

### `campaigns.csv`
| Column | Description |
|---|---|
| campaign_id | Key |
| month | Month, `YYYY-MM` |
| channel | Email, Paid Search, Social, Trade Events, Print & Radio |
| campaign_name | Name |
| spend | Spend in the month |

### `enquiries.csv`
| Column | Description |
|---|---|
| enquiry_id | Key |
| enquiry_date | Date |
| campaign_id, source_channel | Where it came from, where recorded |
| enquiry_type | What the enquirer wanted |
| postcode_area | Where they are |
| became_account | Whether they opened a trade account |

---

## Spreadsheets (`spreadsheets/`)

Exported from Excel, as found.

### `customer_rebates.csv`
Year-end rebates agreed with the biggest customers. Maintained by the sales team.

### `branch_targets_2025.csv`
Monthly revenue targets by branch for 2025.

---

## Reports (`reports/`)

The two monthly revenue reports the board receives. They are company-wide in both the sample and the full dataset.

### `finance_revenue_monthly.csv`
Produced by Finance.
| Column | Description |
|---|---|
| month | `YYYY-MM` |
| invoiced_net | Invoiced in the month, net of VAT |
| credit_notes | Credit notes issued in the month |
| rebate_accrual | Rebates accrued in the month |
| revenue | Revenue as Finance reports it |

### `sales_revenue_monthly.csv`
Produced by the Sales team.
| Column | Description |
|---|---|
| month | `YYYY-MM` |
| orders | Orders placed |
| sales_value | Sales as the Sales team reports it |

---

## AI (`ai/`)

### `ai_usage_log.csv`
One row per AI request, once Halden switches anything on. Empty at the start of Season 1.
| Column | Description |
|---|---|
| timestamp | When |
| use_case | Which AI use case |
| model | Model used |
| input_tokens, output_tokens | Usage |
| cost_gbp | Cost of the request |
| latency_ms | Response time |
| user_staff_id | Who used it |
| outcome | What happened |
