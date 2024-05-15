WITH cte AS (
    SELECT *,
        DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS d_rnk
    FROM Employee
)
SELECT
    d.name AS Department,
    t.name AS Employee,
    t.salary AS Salary
FROM cte t
JOIN Department d
ON t.departmentId = d.id
WHERE t.d_rnk <= 3;