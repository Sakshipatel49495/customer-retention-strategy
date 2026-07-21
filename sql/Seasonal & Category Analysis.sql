/* ============================================================
   SEASONAL AND CATEGORY ANALYSIS     
   ============================================================ */

   -- ============================================================
-- Question: Which seasons attract customers with the lowest previous purchase counts (newer customers)?
-- ============================================================

SELECT
    season,
    COUNT(CASE WHEN previous_purchases = 1 THEN 1 END) AS new_customers,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(CASE WHEN previous_purchases = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS new_customer_percentage
FROM customer_data
GROUP BY season
ORDER BY new_customer_percentage DESC;

-- Insight:
-- • Summer has the highest share of new customers (2.30%), followed by Spring (2.20%).
-- • Winter has the lowest share of new customers (1.85%), while seasonal differences are minimal.

-- ============================================================
-- Question: Which seasons are dominated by customers with high previous purchases (loyal customers)?
-- ============================================================

SELECT
    season,
    COUNT(
        CASE
            WHEN previous_purchases >= (
                SELECT AVG(previous_purchases)
                FROM customer_data
            )
            THEN 1
        END
    ) AS loyal_customers,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(
            CASE
                WHEN previous_purchases >= (
                    SELECT AVG(previous_purchases)
                    FROM customer_data
                )
                THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS loyal_customer_percentage
FROM customer_data
GROUP BY season
ORDER BY loyal_customer_percentage DESC;

-- Insight:
-- • Summer has the highest share of loyal customers (51.94%), closely followed by Winter (51.08%).
-- • Fall has the lowest proportion of loyal customers (47.59%).

-- ============================================================
-- Question: Which product categories are most popular among new customers?
-- ============================================================

SELECT
    category,
    COUNT(*) AS new_customers
FROM customer_data
WHERE previous_purchases = 1
GROUP BY category
ORDER BY new_customers DESC;

-- Insight:
-- • Accessories and Clothing are the most popular categories among new customers, with 28 customers each.
-- • Outerwear is the least preferred category among new customers, with 12 customers.

-- ============================================================
-- Question: Which categories are preferred by long-term, repeat customers?
-- ============================================================

SELECT
    category,
    COUNT(*) AS loyal_customers
FROM customer_data
WHERE previous_purchases >= (
    SELECT AVG(previous_purchases)
    FROM customer_data
)
GROUP BY category
ORDER BY loyal_customers DESC;

-- Insight:
-- • Clothing is the most preferred category among long-term, repeat customers (853), followed by Accessories (627).
-- • Outerwear is the least preferred category among loyal customers (158).

-- ============================================================
-- Question: What is the average spending per season and category?
-- ============================================================

SELECT
    season,
    category,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_spending
FROM customer_data
GROUP BY season, category
ORDER BY season, avg_spending DESC;

-- Insight:
-- • Footwear records the highest average spending in Fall ($63.71), the highest across all season-category combinations.
-- • Outerwear consistently has the lowest average spending across most seasons.

-- ============================================================
-- Question: Which season generates the highest revenue?
-- ============================================================

SELECT
    season,
    SUM(purchase_amount_usd) AS total_revenue
FROM customer_data
GROUP BY season
ORDER BY total_revenue DESC;

-- Insight:
-- • Fall generates the highest total revenue ($60,018).
-- • Summer records the lowest total revenue ($55,777).