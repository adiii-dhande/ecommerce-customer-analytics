# E-Commerce Customer Analytics
> End-to-end data analytics pipeline | BigQuery · dbt · Python · Power BI · Tableau · SQL

## Project Overview
Built a complete analytics pipeline processing **53,132+ orders** across **5,000 customers** — 
automating data cleaning, EDA, and loading into Google BigQuery for scalable reporting. 
Developed dbt data models and interactive dashboards tracking revenue, churn, and retention KPIs.

## Tools & Technologies
| Category | Tools |
|---|---|
| Cloud Data Warehouse | Google BigQuery |
| Data Transformation | dbt (staging, intermediate, Data Marts) |
| Programming | Python (Pandas, NumPy) |
| Visualization | Power BI, Tableau |
| Query Language | SQL (CTEs, Window Functions) |
| Version Control | Git, GitHub |

## Dataset
| Metric | Value |
|---|---|
| Total Orders | 53,132+ |
| Total Customers | 5,000 |
| Customer Segments | 3 (Premium, Standard, Basic) |
| Cities Covered | 8 |
| Dashboards Built | 3 |

## Key Business Metrics Uncovered
- **Total Revenue:** $138M (↑ 24% YoY)
- **Churn Rate:** 25.0% — 1,250 customers churned
- **Retention Rate:** 75.0%
- **Avg Order Value:** $2,596 (↑ 6% YoY)
- **Revenue at Risk:** $34.5M from churned customers
- **Top City by Revenue:** Mumbai — $19.8M

## Pipeline Architecture
```
Raw Data (CSV/Excel/SQL)
        ↓
Python (Pandas, NumPy) — Data Cleaning & EDA
        ↓
Google BigQuery — Cloud Data Warehouse
        ↓
dbt — Staging → Intermediate → Data Marts
        ↓
Power BI / Tableau — KPI Dashboards
```

## dbt Models Built
- **Staging Layer** — raw data standardization
- **Intermediate Layer** — business logic, joins
- **Data Marts** — revenue mart, churn mart, retention mart
- **dbt Tests** — data quality validation across all models
- **dbt Data Dictionary** — column-level documentation

## Dashboards
### Dashboard 1 — Customer Overview
- 6 KPIs: Total Customers, Orders, Revenue, AOV, Churn Rate, Retention Rate
- Customer segment breakdown: Premium ($58M), Standard ($49M), Basic ($31M)
- Top 8 cities by revenue
- Gender distribution
- Monthly acquisition trend

### Dashboard 2 — Revenue & Churn Analysis
- Monthly revenue trend — Active vs Churned
- Churn by segment: Premium 18.4%, Standard 24.8%, Basic 31.6%
- Cohort retention matrix (M0–M5)
- Revenue by product category
- Churn by city — geographic distribution

### Dashboard 3 — Retention & Lifecycle
- Customer lifecycle analysis
- Retention cohort tracking
- Segment-wise lifecycle patterns

## Key SQL Techniques Used
- CTEs for modular query structure
- Window functions for cohort analysis
- Aggregations for revenue and churn metrics
- Joins across customer, order, and product tables

## Author
**Aditya Dhande**
- Email: adidhande35@gmail.com
- LinkedIn: [linkedin.com/in/adityadhande](https://linkedin.com)
- [[Portfolio](https://adityadhande.lovable.app/)]
