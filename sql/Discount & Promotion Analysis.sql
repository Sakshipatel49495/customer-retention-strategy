/* ============================================================
   GEOGRAPHY ANALYSIS     
   ============================================================ */

   -- ============================================================
-- Question: What percentage of customers use promo codes in each location?
-- ============================================================

SELECT
    location,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN promo_code_used = 'Yes' THEN 1 ELSE 0 END) AS promo_used_users,
    ROUND(
        SUM(CASE WHEN promo_code_used = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pct_promo_users
FROM customer_data
GROUP BY location
ORDER BY pct_promo_users DESC;

-- Insight:
-- • Indiana has the highest promo code usage rate (56.96%), followed by Iowa (52.17%) and Oregon (51.35%).
-- • Kansas has the lowest promo code usage (23.81%), indicating customers there rely less on promotional offers.
-- • Promo code adoption varies significantly across locations, suggesting regional differences in promotional engagement.

-- ============================================================
-- Question: Which customer segments are most dependent on discounts?
-- ============================================================

SELECT
    age_group,
    gender,
    ROUND(AVG(dependency_score), 2) AS avg_dependency_score
FROM customer_data
GROUP BY age_group, gender
ORDER BY avg_dependency_score DESC;

-- Insight:
-- • Adult males have the highest average discount dependency score (1.28), followed closely by mature (1.26) and young adult males (1.24).
-- • All female segments have an average dependency score of 0.00, indicating no recorded reliance on discounts or promo codes in this dataset.
-- • The results suggest that promotional dependency varies significantly across customer segments, although this pattern is influenced by the characteristics of the dataset.

-- ============================================================
-- Question: Do customers who use discounts spend more or less than non-discount customers?
-- ============================================================

SELECT
    discount_applied,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_amount_spent
FROM customer_data
GROUP BY discount_applied;

-- Insight:
-- • Customers who did not use discounts spent slightly more on average ($60.13) than those who used discounts ($59.28).
-- • The difference in average spending is minimal, suggesting that discount usage has little impact on purchase amount in this dataset.

-- ============================================================
-- Question: Which categories have the highest promotional dependency?
-- ============================================================

SELECT
    category,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(CASE WHEN promo_code_used = 'Yes' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS pct_promo_dependency
FROM customer_data
GROUP BY category
ORDER BY pct_promo_dependency DESC;

-- Insight:
-- • Outerwear has the highest promotional dependency, with 44% of customers using promo codes.
-- • Accessories (43%) and Footwear (43%) also show relatively high promotional engagement.
-- • Promo code usage is fairly consistent across product categories, ranging from 42% to 44%, indicating similar promotional effectiveness across the product mix.

-- ============================================================
-- Question: Are repeat customers less dependent on promotions than new customers?
-- ============================================================

WITH customer_segments AS (
    SELECT
        promo_code_used,
        CASE
            WHEN previous_purchases >= (
                SELECT AVG(previous_purchases)
                FROM customer_data
            )
            THEN 'Repeat Customer'
            ELSE 'New Customer'
        END AS customer_type
    FROM customer_data
)

SELECT
    customer_type,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(CASE WHEN promo_code_used = 'Yes' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS pct_promo_users
FROM customer_segments
GROUP BY customer_type
ORDER BY pct_promo_users DESC;

-- Insight:
-- • New customers have a slightly higher promo code usage rate (43%) than repeat customers (42%).
-- • The difference is minimal, indicating that repeat purchasing behavior has little influence on promotional dependency in this dataset.