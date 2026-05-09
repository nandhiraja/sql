SELECT COUNT(*) AS employee_count, AVG(salary) AS avg_salary, SUM(salary) AS total_salary
FROM employees;

SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY department_id;


SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 2
ORDER BY department_id;