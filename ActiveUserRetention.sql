WITH july_cte AS (
  SELECT *,EXTRACT(month from event_date) as mo FROM user_actions WHERE 
  EXTRACT(month from event_date) = 7
  AND
  EXTRACT(year from event_date) = 2022
  AND
  event_type IN ('sign-in', 'like', 'comment')
),
june_cte AS (
  SELECT *,EXTRACT(month from event_date) as mo FROM user_actions WHERE 
  EXTRACT(month from event_date) = 6
  AND
  EXTRACT(year from event_date) = 2022
  AND
  event_type IN ('sign-in', 'like', 'comment')
)


SELECT jul.mo AS mth, COUNT(DISTINCT(jul.user_id)) as monthly_active_users
FROM july_cte jul JOIN june_cte jun ON jul.user_id = jun.user_id
GROUP BY 1;