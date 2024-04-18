USE jobs_db;

CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY,
    name VARCHAR(50),
    DepartmentID INT,
    salary DECIMAL(10, 2)
);

INSERT INTO employees (EmployeeID, name, DepartmentID, salary) VALUES
(1, 'John', 1, 50000.00),
(2, 'Alice', 1, 52000.00),
(3, 'Bob', 2, 60000.00),
(4, 'Sarah', 2, 58000.00),
(5, 'Emily', 3, 56000.00),
(6, 'David', 3, 51000.00),
(7, 'Michael', 1, 54000.00),
(8, 'Sophia', 1, 55000.00),
(9, 'William', 2, 51000.00),
(10, 'Olivia', 2, 60000.00),
(11, 'James', 3, 52000.00),
(12, 'Emma', 3, 52000.00),
(13, 'Alexander', 4, 55000.00),
(14, 'Ava', 4, 55000.00);

SELECT * FROM jobs_db.employees;

/*---------------
Find employees who earn more than overall average salary of all employees
but his/her salary is not equal to anyother employee within the corresponding department
-----------------*/
SELECT * FROM
(
	SELECT e.EmployeeID, e.name, e.DepartmentID, e.salary
	FROM employees e
	WHERE NOT EXISTS (
		SELECT *
		FROM employees e2
		WHERE e2.DepartmentID = e.DepartmentID
		AND e2.salary = e.salary
		AND e2.EmployeeID <> e.EmployeeID
	)
) d
WHERE d.salary > (SELECT AVG(salary) FROM employees);

-- ALTERNATIVE SOLUTION
SELECT e.EmployeeID, e.name, e.DepartmentID, e.salary
FROM employees e
JOIN (
    SELECT AVG(salary) AS avg_sal
    FROM employees
) AS overall_avg ON e.salary > overall_avg.avg_sal
WHERE NOT EXISTS (
    SELECT *
    FROM employees e2
    WHERE e2.DepartmentID = e.DepartmentID
    AND e2.salary = e.salary
    AND e2.EmployeeID <> e.EmployeeID
);
