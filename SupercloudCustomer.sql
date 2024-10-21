WITH main_cte AS (SELECT 
customer_id, product_category
FROM customer_contracts cc
JOIN products p ON cc.product_id = p.product_id
ORDER BY 1),
analytics_cte AS (
  SELECT * FROM main_cte WHERE product_category = 'Analytics'
),
container_cte AS (
  SELECT * FROM main_cte WHERE product_category = 'Containers'
),
compute_cte AS (
  SELECT * FROM main_cte WHERE product_category = 'Compute'
)

SELECT DISTINCT(customer_id) FROM analytics_cte
INTERSECT
SELECT DISTINCT(customer_id) FROM container_cte
INTERSECT
SELECT DISTINCT(customer_id) FROM compute_cte