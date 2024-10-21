SELECT 
EXTRACT(year from transaction_date) as yr,
product_id, spend as curr_year_spend,
LAG(spend) OVER(PARTITION BY product_id ) as prev_year_spend,
ROUND(100.0 * ((spend-LAG(spend) OVER(PARTITION BY product_id)) / LAG(spend) OVER(PARTITION BY product_id)),2) as yoy_rate
FROM user_transactions;