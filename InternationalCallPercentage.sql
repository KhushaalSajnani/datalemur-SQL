WITH main_cte AS (
SELECT pc.*, pi.country_id CC, pi2.country_id as RC
FROM phone_calls pc
JOIN phone_info pi ON pc.caller_id = pi.caller_id 
JOIN phone_info pi2 ON pc.receiver_id = pi2.caller_id
),
perc_cte AS (
  SELECT
  COUNT(*) as total_calls,
  SUM(
    CASE 
      WHEN
        cc <> rc
      THEN
        1
      ELSE
        0
    END
  ) as intl_calls
  FROM main_cte
)

SELECT ROUND(100.0 * (CAST(intl_calls as numeric)/CAST(total_calls as numeric)),1) as international_calls_pct FROM perc_cte;

