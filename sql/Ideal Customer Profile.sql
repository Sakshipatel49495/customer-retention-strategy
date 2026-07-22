/* ============================================================
    IDEAL CUSTOMER PROFILE    
   ============================================================ */

-- ============================================================
-- Question: What are the demographics of the highest-spending repeat customers?
-- ============================================================

WITH repeat_customers AS (
    SELECT *
    FROM customer_data
    WHERE previous_purchases >= (
        SELECT AVG(previous_purchases)
        FROM customer_data
    )
)

SELECT
    age_group,
    gender,
    subscription_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases,
    SUM(purchase_amount_usd) AS total_revenue
FROM repeat_customers
GROUP BY age_group, gender, subscription_status
ORDER BY avg_purchase_amount DESC, total_revenue DESC;

-- Insight:
-- • Adult female non-subscribers are the highest-spending repeat customer segment, with an average purchase amount of $62.82.
-- • Mature male non-subscribers contribute the highest total revenue ($28,569), making them the most valuable repeat customer segment by overall sales.
-- • Most top-performing repeat customer segments average around 38 previous purchases, indicating consistently high customer loyalty across these groups.

-- ============================================================
-- Question: Which combination of age, gender, category, and subscription status
-- produces the highest customer value?
-- ============================================================

SELECT
    age_group,
    gender,
    category,
    subscription_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases,
    SUM(purchase_amount_usd) AS total_revenue
FROM customer_data
GROUP BY
    age_group,
    gender,
    category,
    subscription_status
ORDER BY
    total_revenue DESC,
    avg_purchase_amount DESC;

-- Insight:
-- • Mature male customers purchasing Clothing without a subscription generate the highest total revenue ($24,008), making them the most valuable customer segment.
-- • Clothing consistently emerges as the highest-value product category, with mature and adult customers contributing the largest share of revenue across both genders.
-- • Although a few smaller segments (e.g., young adult males buying Footwear) have higher average purchase amounts, the greatest customer value comes from larger,
--  loyal customer segments that generate consistently high total revenue.

-- ============================================================
-- Question: What does the average high-value customer look like?
-- ============================================================

SELECT
    age_group,
    gender,
    subscription_status,
    category,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_data
WHERE value_tier = 'High Value'
GROUP BY
    age_group,
    gender,
    subscription_status,
    category
ORDER BY
    total_customers DESC,
    avg_purchase_amount DESC;

-- Insight:
-- • The largest high-value customer segment consists of mature male customers purchasing Clothing.
-- • Clothing and Accessories are the most common categories among high-value customers.
-- • High-value customers combine high average spending ($75–$85) with strong repeat purchase behavior (30–37 previous purchases).

