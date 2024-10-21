WITH open_cte AS (
  SELECT *, 
  RANK() OVER(PARTITION BY ticker ORDER BY open DESC) as high_open_sort,
  RANK() OVER(PARTITION BY ticker ORDER BY open) as low_open_sort,
  left(to_char(CAST(date as DATE), 'Month'), 3) || '-' || extract(year from date) as month_detail
  FROM stock_prices
),
high_open_cte AS (
  SELECT ticker, month_detail as highest_mth, open as highest_open FROM open_cte WHERE high_open_sort = 1 
),
low_open_cte AS (
  SELECT ticker, month_detail as lowest_mth, open as lowest_open FROM open_cte WHERE low_open_sort = 1 
)

SELECT hoc.*, loc.lowest_mth, loc.lowest_open  FROM
high_open_cte hoc 
JOIN low_open_cte loc ON hoc.ticker = loc.ticker;