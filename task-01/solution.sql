CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    salary NUMERIC(10,2) NOT NULL CHECK (salary > 0),
    hire_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date, email, manager_id) VALUES
(1, 'Arun', 'Kumar', 1, 75000, '2022-01-15', 'arun.kumar@demo.com', NULL),
(2, 'Priya', 'Sharma', 1, 62000, '2023-03-10', 'priya.sharma@demo.com', 1),
(3, 'Vijay', 'Rajan', 2, 90000, '2021-07-22', 'vijay.rajan@demo.com', NULL),
(4, 'Meera', 'Iyer', 2, 88000, '2024-02-05', 'meera.iyer@demo.com', 3),
(5, 'Karthik', 'Sundar', 3, 55000, '2023-11-18', 'karthik.sundar@demo.com', NULL),
(6, 'Anita', 'Jose', 4, 70000, '2022-09-01', 'anita.jose@demo.com', NULL),
(7, 'Ravi', 'Menon', 5, 60000, '2024-05-20', 'ravi.menon@demo.com', NULL),
(8, 'Divya', 'Nair', 1, 68000, '2024-06-11', 'divya.nair@demo.com', 1);



SELECT * FROM employees;
