SELECT *
FROM employees
WHERE department_id = 1
ORDER BY salary DESC;

SELECT *
FROM employees
WHERE department_id = 1 AND salary > 65000
ORDER BY last_name;

SELECT *
FROM customers
WHERE city = 'Chennai' OR city = 'Bangalore'
ORDER BY first_name;