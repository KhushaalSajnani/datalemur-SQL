SELECT * FROM  
  (SELECT 
  transaction_date, user_id, COUNT(*) as c
  FROM user_transactions
  GROUP BY 1,2
  ORDER BY 1 DESC, 3
  LIMIT 3) t
ORDER BY 1 ;