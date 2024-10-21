SELECT user_id, spend, transaction_date FROM 
(
SELECT *,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) as tr_rank
FROM transactions
) as temp_t
WHERE tr_rank = 3;