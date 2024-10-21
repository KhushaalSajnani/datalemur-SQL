WITH dept_avg_cte AS 
(
  SELECT e.*, s.payment_date,
  ROUND(AVG(s.amount) OVER(PARTITION BY department_id),2) as avg_dept,
  ROUND(AVG(s.amount) OVER(),2) as comp_avg
  FROM employee e
  JOIN salary s ON e.employee_id = s.employee_id  
  WHERE EXTRACT(month from s.payment_date) = 3 AND EXTRACT(year from s.payment_date) = 2024
), compressed_cte AS 
(
  SELECT DISTINCT(department_id), avg_dept, comp_avg, '03-2024' as payment_date FROM dept_avg_cte
)
, 
result_cte AS 
(
  SELECT department_id, payment_date,
  CASE 
    WHEN avg_dept < comp_avg THEN 'lower'
    WHEN avg_dept > comp_avg THEN 'higher'
    ELSE 'same'
  END as comparison
  FROM compressed_cte
)

SELECT * FROM result_cte;