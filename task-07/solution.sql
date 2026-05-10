SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank,
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_salary_rank
FROM employees
ORDER BY department_id, salary DESC;

SELECT
    employee_id,
    first_name,
    salary,
    LAG(salary) OVER (PARTITION BY department_id ORDER BY salary DESC) AS previous_salary,
    LEAD(salary) OVER (PARTITION BY department_id ORDER BY salary DESC) AS next_salary
FROM employees;
