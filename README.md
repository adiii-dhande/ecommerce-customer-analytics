# E-Commerce Customer Analytics

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)

End-to-end analytics pipeline processing **53,132+ orders** across **5,000 customers** — tracking revenue, churn, and retention KPIs through interactive Power BI dashboards.

## Key Metrics

| Metric | Value |
|--------|-------|
| Total Customers | 5,000 |
| Total Orders | 53,132 |
| Total Revenue | $109.1M |
| Avg Order Value | $2,054 |
| Churn Rate | 25.9% |
| Retention Rate | 74.1% |
| Revenue at Risk | $7.6M |
| Top City | Mumbai — $24.6M |

## Pipeline Architecture

Raw Data (Excel / SQL) → Python (Pandas, NumPy) — Data Cleaning & EDA → Google BigQuery — Cloud Data Warehouse → dbt — Staging → Intermediate → Data Marts → Power BI — 3 Interactive KPI Dashboards

## Dataset

| Sheet | Rows | Description |
|-------|------|-------------|
| Customers | 5,000 | Demographics, segment, churn flag |
| Orders | 53,132 | Order value, category, city, date |
| KPI Summary | — | Pre-aggregated headline metrics |
| Segment Summary | — | Premium / Standard / Basic breakdown |

## Dashboards

### Dashboard 1 — Customer Overview

- 6 KPI Cards — Total Customers, Orders, Revenue, AOV, Churn Rate, Retention Rate
- Monthly Acquisition Trend — New customers (bars) + Orders (line) combo chart
- Customer Segment Breakdown — Premium / Standard / Basic donut
- Orders by Category — Electronics, Clothing, Home, Books, Sports
- Gender Distribution — Male 53.7% / Female 46.3%
- Top 8 Cities by Revenue — Mumbai $24.6M to Ahmedabad $4.3M
- Slicers — Year | Segment | City | Gender

### Dashboard 2 — Revenue & Churn Analysis

- Monthly Revenue Trend — Active vs Churned revenue
- Churn Rate by Segment — donut + breakdown table
- Revenue by Segment — grouped bar (Active vs Churned)
- Churn by City — geographic distribution
- Cohort Retention Matrix — M0 to M5
- Orders by Quarter — 2023 vs 2024 comparison

| Segment | Customers | Revenue | Churn Rate |
|---------|-----------|---------|------------|
| Premium | 1,646 | $60.5M | 18.7% |
| Standard | 1,659 | $33.3M | 25.3% |
| Basic | 1,695 | $15.3M | 33.4% |

### Dashboard 3 — Retention & Lifecycle

- Retention Rate Trend — 24-month rolling
- Customer Lifecycle Funnel — Acquired → Retained → Churned
- Repeat vs One-Time Buyers
- Retention by Segment
- Top 10 Customers by Lifetime Value

## DAX Measures

    Total Customers = COUNTROWS(Customers)
    
    Total Orders = COUNTROWS(Orders)
    
    Total Revenue = SUM(Orders[ORDER VALUE ($)])
    
    Avg Order Value = DIVIDE([Total Revenue], [Total Orders])
    
    Churn Rate % = DIVIDE(CALCULATE(COUNTROWS(Customers), Customers[CHURN]=1), COUNTROWS(Customers)) * 100
    
    Retention Rate % = 100 - [Churn Rate %]
    
    Active Customers = CALCULATE(COUNTROWS(Customers), Customers[RETENTION]=1)
    
    Revenue at Risk = CALCULATE([Total Revenue], Customers[CHURN]=1)

## Key SQL Techniques

- CTEs for modular query structure
- Window functions — ROW_NUMBER, RANK, SUM OVER for cohort analysis
- Aggregations for revenue and churn metrics
- Joins across customer, order, and product tables

## dbt Models

| Layer | Model | Description |
|-------|-------|-------------|
| Staging | stg_customers | Raw customer data standardization |
| Staging | stg_orders | Raw order data standardization |
| Intermediate | int_customer_orders | Customer + order joins |
| Mart | mart_revenue | Revenue by segment/city/category |
| Mart | mart_churn | Churn metrics and risk scoring |
| Mart | mart_retention | Cohort retention calculations |

## Tech Stack

| Category | Tools |
|----------|-------|
| Cloud Data Warehouse | Google BigQuery |
| Data Transformation | dbt |
| Programming | Python (Pandas, NumPy) |
| Visualization | Power BI, Tableau |
| Query Language | SQL (CTEs, Window Functions) |
| Version Control | Git, GitHub |

## Author

**Aditya Dhande**

- Email: adityadhande35@gmail.com
- LinkedIn: https://linkedin.com/in/adiii-dhande
- GitHub: https://github.com/adiii-dhande
