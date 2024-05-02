-- Using Sub-query

SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'
OR employee_id IN(
    SELECT employee_id
    FROM Employee
    GROUP BY employee_id
    HAVING COUNT(department_id) = 1
);

-- Using JOIN

SELECT e.employee_id, e.department_id
FROM Employee e
JOIN
(SELECT employee_id, COUNT(department_id) AS num_dept
FROM Employee
GROUP BY employee_id) d
ON e.employee_id = d.employee_id
WHERE d.num_dept = 1
OR (d.num_dept > 1 AND e.primary_flag = 'Y');