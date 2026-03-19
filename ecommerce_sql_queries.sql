-- ============================================================
-- E-Commerce Customer Analytics
-- SQL Queries — BigQuery / dbt
-- Author: Aditya Dhande
-- ============================================================


-- ── 1. Total Revenue & Orders KPIs ───────────────────────────────────────────
SELECT
    COUNT(DISTINCT order_id)               AS total_orders,
    COUNT(DISTINCT customer_id)            AS total_customers,
    ROUND(SUM(order_value) / 1e6, 1)      AS total_revenue_m,
    ROUND(AVG(order_value), 0)             AS avg_order_value
FROM ecommerce_orders;


-- ── 2. Revenue by Customer Segment ───────────────────────────────────────────
SELECT
    c.segment,
    COUNT(DISTINCT o.order_id)             AS total_orders,
    COUNT(DISTINCT o.customer_id)          AS total_customers,
    ROUND(SUM(o.order_value) / 1e6, 1)    AS revenue_m,
    ROUND(AVG(o.order_value), 0)           AS avg_order_value
FROM ecommerce_orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY revenue_m DESC;


-- ── 3. Churn Rate by Segment ──────────────────────────────────────────────────
SELECT
    segment,
    COUNT(*)                                           AS total_customers,
    SUM(churn)                                         AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 1)           AS churn_rate_pct,
    ROUND((1 - SUM(churn) * 1.0 / COUNT(*)) * 100, 1) AS retention_rate_pct
FROM customers
GROUP BY segment
ORDER BY churn_rate_pct DESC;


-- ── 4. Monthly Revenue Trend (2023-2024) ─────────────────────────────────────
SELECT
    DATE_TRUNC(order_date, MONTH)          AS order_month,
    COUNT(DISTINCT order_id)               AS total_orders,
    ROUND(SUM(order_value) / 1e6, 2)      AS revenue_m,
    COUNT(DISTINCT customer_id)            AS active_customers
FROM ecommerce_orders
GROUP BY order_month
ORDER BY order_month;


-- ── 5. Revenue at Risk from Churned Customers ────────────────────────────────
SELECT
    c.segment,
    COUNT(DISTINCT CASE WHEN c.churn = 1 THEN o.customer_id END) AS churned_customers,
    ROUND(SUM(CASE WHEN c.churn = 1 THEN o.order_value ELSE 0 END) / 1e6, 1) AS revenue_at_risk_m
FROM ecommerce_orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY revenue_at_risk_m DESC;


-- ── 6. Top Cities by Revenue ──────────────────────────────────────────────────
SELECT
    c.city,
    COUNT(DISTINCT o.order_id)             AS total_orders,
    COUNT(DISTINCT o.customer_id)          AS total_customers,
    ROUND(SUM(o.order_value) / 1e6, 1)    AS revenue_m
FROM ecommerce_orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY revenue_m DESC
LIMIT 8;


-- ── 7. Orders by Product Category ────────────────────────────────────────────
SELECT
    category,
    COUNT(order_id)                        AS total_orders,
    ROUND(SUM(order_value) / 1e6, 1)      AS revenue_m,
    ROUND(AVG(order_value), 0)             AS avg_order_value
FROM ecommerce_orders
GROUP BY category
ORDER BY revenue_m DESC;


-- ── 8. Cohort Retention Analysis (Window Functions) ──────────────────────────
WITH cohort_base AS (
    SELECT
        customer_id,
        DATE_TRUNC(MIN(order_date), MONTH) AS cohort_month
    FROM ecommerce_orders
    GROUP BY customer_id
),
cohort_orders AS (
    SELECT
        o.customer_id,
        cb.cohort_month,
        DATE_TRUNC(o.order_date, MONTH) AS order_month,
        DATE_DIFF(DATE_TRUNC(o.order_date, MONTH),
                  cb.cohort_month, MONTH) AS months_since_first
    FROM ecommerce_orders o
    JOIN cohort_base cb ON o.customer_id = cb.customer_id
)
SELECT
    cohort_month,
    months_since_first,
    COUNT(DISTINCT customer_id)     AS active_customers,
    ROUND(
        COUNT(DISTINCT customer_id) * 100.0 /
        FIRST_VALUE(COUNT(DISTINCT customer_id))
            OVER (PARTITION BY cohort_month ORDER BY months_since_first),
        1
    )                               AS retention_rate_pct
FROM cohort_orders
GROUP BY cohort_month, months_since_first
ORDER BY cohort_month, months_since_first;


-- ── 9. Revenue YoY Growth ─────────────────────────────────────────────────────
WITH yearly AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS order_year,
        ROUND(SUM(order_value) / 1e6, 1) AS revenue_m
    FROM ecommerce_orders
    GROUP BY order_year
)
SELECT
    order_year,
    revenue_m,
    LAG(revenue_m) OVER (ORDER BY order_year)  AS prev_year_revenue,
    ROUND(
        (revenue_m - LAG(revenue_m) OVER (ORDER BY order_year))
        * 100.0 / LAG(revenue_m) OVER (ORDER BY order_year),
        1
    )                                           AS yoy_growth_pct
FROM yearly
ORDER BY order_year;


-- ── 10. Customer Lifetime Value by Segment ───────────────────────────────────
SELECT
    c.segment,
    ROUND(AVG(customer_total.total_spend), 0)  AS avg_clv,
    ROUND(MAX(customer_total.total_spend), 0)  AS max_clv,
    ROUND(MIN(customer_total.total_spend), 0)  AS min_clv
FROM (
    SELECT
        customer_id,
        SUM(order_value) AS total_spend
    FROM ecommerce_orders
    GROUP BY customer_id
) customer_total
JOIN customers c ON customer_total.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY avg_clv DESC;
