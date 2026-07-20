/* ============================================================
   REPEAT PURCHASE BEHAVIOUR    
   ============================================================ */

-- ============================================================
-- Question: Which age groups exhibit the strongest repeat purchase behavior?
-- ============================================================

SELECT
    age_group,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_data
GROUP BY age_group
ORDER BY avg_previous_purchases DESC;

-- Insight:
-- • Mature customers have the highest average previous purchases (25.69).
-- • Young Adult customers have the lowest average previous purchases (24.63).

-- ============================================================
-- Question: Which product categories have customers with the highest average previous purchases?
-- ============================================================

SELECT
    category,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_data
GROUP BY category
ORDER BY avg_previous_purchases DESC;

-- Insight:
-- • Accessories have the highest average previous purchases (25.73), indicating the strongest repeat buying behavior.
-- • Outerwear has the lowest average (24.96), though the difference across categories is minimal.
-- • Overall, repeat purchase behavior is fairly consistent across all product categories.

-- ============================================================
-- Question: What is the relationship between purchase frequency and previous purchases?
-- ============================================================

SELECT
    frequency_of_purchases,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_data
GROUP BY frequency_of_purchases
ORDER BY avg_previous_purchases DESC;

-- Insight:
-- • Customers with quarterly purchase frequency have the highest average previous purchases (26.85).
-- • Annual shoppers have the lowest average previous purchases (24.56).
-- • Overall, the difference across purchase frequencies is minimal, indicating a weak relationship between purchase frequency and previous purchases.

-- ============================================================
-- Question: Which payment methods are preferred by repeat customers?
-- ============================================================

WITH cte AS (
    SELECT
        CASE
            WHEN previous_purchases >= (
                SELECT AVG(previous_purchases)
                FROM customer_data
            ) THEN 'High Repeat'
            ELSE 'Low Repeat'
        END AS repeat_category,
        payment_method
    FROM customer_data
)

SELECT
    payment_method,
    COUNT(*) AS no_of_customers
FROM cte
WHERE repeat_category = 'High Repeat'
GROUP BY payment_method
ORDER BY no_of_customers DESC;

-- Insight:
-- • PayPal is the most preferred payment method among high-repeat customers (351 customers).
-- • Credit Card (333) and Cash (330) are also popular choices among repeat buyers.
-- • Bank Transfer is the least preferred payment method (293 customers) within the high-repeat customer segment.

