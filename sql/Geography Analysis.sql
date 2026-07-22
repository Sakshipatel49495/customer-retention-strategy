/* ============================================================
   GEOGRAPHY ANALYSIS     
   ============================================================ */

   -- ============================================================
-- Question: Which locations generate the highest total revenue?
-- ============================================================

SELECT
    location,
    SUM(purchase_amount_usd) AS total_revenue
FROM customer_data
GROUP BY location
ORDER BY total_revenue DESC;

-- Insight:
-- • Montana generates the highest total revenue ($5,784), followed by Illinois ($5,617) and California ($5,605).
-- • Kansas records the lowest total revenue ($3,437).
-- • Revenue is fairly evenly distributed across locations, with no major outlier.


-- ============================================================
-- Question: Which locations rely the most on discounts and promo codes?
-- ============================================================

SELECT
    location,
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN discount_applied = 'Yes'
             AND promo_code_used = 'Yes'
            THEN 1
            ELSE 0
        END
    ) AS promo_users,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN discount_applied = 'Yes'
                 AND promo_code_used = 'Yes'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS promo_dependency_pct
FROM customer_data
GROUP BY location
ORDER BY promo_dependency_pct DESC;

-- Insight:
-- • Indiana has the highest promo dependency (56.96%), indicating customers there are the most responsive to combined discount and promo code offers.
-- • Kansas has the lowest promo dependency (23.81%), suggesting purchasing behavior is less influenced by promotions.

-- ============================================================
-- Question: Which locations generate strong revenue despite low promotional usage (organic demand)?
-- ============================================================

SELECT
    location,
    SUM(purchase_amount_usd) AS total_revenue,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN discount_applied = 'Yes'
                 AND promo_code_used = 'Yes'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS promo_dependency_pct
FROM customer_data
GROUP BY location
ORDER BY total_revenue DESC, promo_dependency_pct ASC;

-- Insight:
-- • Montana, Tennessee, Texas, and Virginia generate strong revenue while maintaining relatively low promotional dependency, indicating strong organic customer demand.
-- • These locations may require fewer discounts to drive sales, helping improve profitability.

-- ============================================================
-- Question: Which locations have the highest proportion of repeat customers?
-- ============================================================

WITH customer_segments AS (
    SELECT
        location,
        CASE
            WHEN previous_purchases >= (
                SELECT AVG(previous_purchases)
                FROM customer_data
            )
            THEN 1
            ELSE 0
        END AS repeat_customer
    FROM customer_data
)

SELECT
    location,
    COUNT(*) AS total_customers,
    SUM(repeat_customer) AS repeat_customers,
    ROUND(100.0 * SUM(repeat_customer) / COUNT(*), 2) AS repeat_customer_pct
FROM customer_segments
GROUP BY location
ORDER BY repeat_customer_pct DESC;

-- Insight:
-- • Hawaii has the highest proportion of repeat customers (63.08%), indicating the strongest customer loyalty and retention.
-- • Rhode Island records the lowest proportion (36.51%), suggesting comparatively weaker repeat purchase behavior.