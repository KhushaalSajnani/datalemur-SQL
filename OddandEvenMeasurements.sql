WITH 
rowed_cte AS (
  SELECT 
  *,
  ROW_NUMBER() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time)
  FROM measurements
),
oe_value_cte AS (
  SELECT measurement_value, measurement_time, row_number,
  CASE
    WHEN
      row_number % 2 = 0
    THEN
      measurement_value
    ELSE
      0
  END AS even_row,
  CASE
    WHEN
      row_number % 2 <> 0
    THEN
      measurement_value
    ELSE
      0
  END AS odd_row
  FROM rowed_cte
),
result_cte AS (
  SELECT DATE(measurement_time) as measurement_day,
  SUM(odd_row) as odd_sum,
  SUM(even_row) as even_sum
  FROM oe_value_cte
  GROUP BY 1
)


SELECT * FROM result_cte ORDER BY 1;