SELECT salary as second_highest_salary FROM (SELECT *,
RANK() OVER(ORDER BY salary DESC) as s_rank
FROM employee) as t
WHERE t.s_rank = 2;