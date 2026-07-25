-- ==============================================================================
-- Project: 2018 Monthly Category Revenue Analysis
-- Objective: Generate a monthly sales report filtering out NULL categories,
--            calculating net revenue, and classifying performance tiers.
-- Engine: SQLite
-- ==============================================================================

SELECT
    -- 1. Total revenue excluding freight charges (NULL-safe)
    SUM(COALESCE(oi.price - oi.freight_value, 0)) AS total_revenue,
    
    -- 2. Standardized product category name in UPPERCASE
    UPPER(p.product_category_name) AS category,
    
    -- 3. Extracted sales month converted to integer
    CAST(STRFTIME('%m', o.order_delivered_customer_date) AS INTEGER) AS sales_month,
    
    -- 4. Dynamic performance tier classification
    CASE
        WHEN SUM(COALESCE(oi.price - oi.freight_value, 0)) > 10000 THEN 'Top Performer'
        ELSE 'Standard'
    END AS sales_classification

FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id

-- Initial Filter: Delivered in 2018 only + Valid non-null categories
WHERE CAST(STRFTIME('%Y', o.order_delivered_customer_date) AS INTEGER) = 2018 
  AND p.product_category_name IS NOT NULL

-- Grouping by Category and Month
GROUP BY 
    UPPER(p.product_category_name),
    CAST(STRFTIME('%m', o.order_delivered_customer_date) AS INTEGER)

-- Post-aggregation Filter: Only categories generating over $1,000 per month
HAVING total_revenue > 1000

-- Ordering from highest to lowest revenue
ORDER BY total_revenue DESC;