WITH my_cte AS (SELECT a.user_id, ab.age_bucket,
CASE 
  WHEN 
    activity_type = 'open' 
  THEN ROUND(100 * (a.time_spent / t.sum), 2)
END as open_perc_up,
CASE 
  WHEN 
    activity_type = 'send' 
  THEN ROUND(100 * (a.time_spent / t.sum), 2)
END as send_perc_up
FROM 
(
SELECT user_id,
SUM(CASE WHEN activity_type IN ('open','send') THEN time_spent ELSE 0 END)
FROM activities
GROUP BY 1
) as t 
JOIN activities a ON t.user_id = a.user_id
JOIN age_breakdown ab ON a.user_id = ab.user_id
)

SELECT age_bucket,SUM(send_perc_up) as send_perc, SUM(open_perc_up) as open_perc FROM my_cte GROUP BY age_bucket;

