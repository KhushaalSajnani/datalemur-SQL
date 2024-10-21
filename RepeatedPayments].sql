WITH lag_cte AS (
SELECT *,
LAG(transaction_timestamp) OVER(PARTITION BY merchant_id,credit_card_id,amount ORDER BY transaction_timestamp) as prev_date
FROM transactions
) 

SELECT COUNT(*)
FROM lag_cte
WHERE EXTRACT(EPOCH FROM transaction_timestamp - prev_date)/60 <= 10.0;