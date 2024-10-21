WITH lag_cte AS (
  SELECT *,
  LAG(status_time) OVER(PARTITION BY server_id ORDER BY status_time) as start_time
  FROM server_utilization
), stop_cte AS (
  SELECT *,
  ROUND((EXTRACT(EPOCH from status_time - start_time)/86400), 1) as diff
  FROM lag_cte WHERE session_status = 'stop'
), days_cte AS (
  SELECT SUM(diff) FROM stop_cte GROUP BY server_id
)

SELECT FLOOR(SUM(sum)) as total_uptime_days FROM days_cte;