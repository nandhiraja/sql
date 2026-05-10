WITH department_summary AS (
    SELECT department_id, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_summary
WHERE avg_salary > 60000
ORDER BY avg_salary DESC;



WITH RECURSIVE org_chart AS (
    SELECT employee_id, employee_name, manager_id, 0 AS level_no
    FROM employeehierarchy
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.employee_name, e.manager_id, oc.level_no + 1
    FROM employeehierarchy e
    JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT *
FROM org_chart
ORDER BY level_no, employee_id;
