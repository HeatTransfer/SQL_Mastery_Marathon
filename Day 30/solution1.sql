-- Write your MySQL query statement below

WITH cte AS
(SELECT *, DENSE_RANK() OVER(ORDER BY salary DESC) AS d_rank
FROM Employee) 

SELECT (
    SELECT DISTINCT salary
    FROM cte 
    WHERE d_rank = 2
) AS SecondHighestSalary;

-- Another approach

SELECT (
    SELECT DISTINCT salary 
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
