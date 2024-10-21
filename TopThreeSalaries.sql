WITH whole_table AS (
  SELECT e.employee_id, e.name, e.salary, d.department_name 
  FROM employee e
  JOIN department d ON e.department_id = d.department_id
),
ranked_cte AS (
  SELECT *,
  DENSE_RANK() OVER(PARTITION BY department_name ORDER BY salary DESC) as rank 
  FROM whole_table
)

SELECT department_name, name, salary
FROM ranked_cte
WHERE rank <= 3
ORDER BY 1, 3 DESC;