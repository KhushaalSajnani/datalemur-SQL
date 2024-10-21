WITH grouped_cte AS (
  SELECT category, product, SUM(spend) as spend
  FROM product_spend
  WHERE EXTRACT(year from transaction_date) = 2022
  GROUP BY 1,2
), 
ranked_cte AS(
  SELECT *,
  RANK() OVER(PARTITION BY category ORDER BY spend DESC) as ar
  FROM grouped_cte
)

SELECT category, product, spend as total_spend 
FROM ranked_cte
WHERE ar <= 2;