WITH joined_cte AS (
SELECT a.user_id, a.status, COALESCE(dp.paid, 0) as paid
FROM advertiser a 
LEFT JOIN daily_pay dp 
ON a.user_id = dp.user_id

UNION

SELECT COALESCE(a.user_id, dp.user_id), COALESCE(COALESCE(a.status, dp.status), 'NULL'), COALESCE(dp.paid, 0) as paid
FROM  daily_pay dp
LEFT JOIN  advertiser a
ON a.user_id = dp.user_id
)


SELECT user_id,
CASE 
  WHEN status = 'NULL' AND paid <> 0 THEN 'NEW'
  WHEN status = 'NEW' AND paid <> 0 THEN 'EXISTING'
  WHEN status = 'NEW' AND paid = 0 THEN 'CHURN'
  WHEN status = 'EXISTING' AND paid <> 0 THEN 'EXISTING'
  WHEN status = 'EXISTING' AND paid = 0 THEN 'CHURN'
  WHEN status = 'CHURN' AND paid <> 0 THEN 'RESURRECT'
  WHEN status = 'CHURN' AND paid = 0 THEN 'CHURN'
  WHEN status = 'RESURRECT' AND paid = 0 THEN 'CHURN'
  WHEN status = 'RESURRECT' AND paid <> 0 THEN 'EXISTING'
END as new_status
FROM joined_cte
ORDER BY user_id;

