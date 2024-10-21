SELECT t.user_id, t.tweet_date, ROUND(t.my_avg_sol, 2) as avg FROM (SELECT *, 
AVG(tweet_count) OVER(PARTITION BY user_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) as my_avg_sol
FROM tweets) as t