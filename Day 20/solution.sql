# Write your MySQL query statement below

WITH cte1 AS(
    SELECT 'Low Salary' AS category UNION
    SELECT 'Average Salary' AS category UNION
    SELECT 'High Salary' AS category
),
cte2 AS(
    SELECT
        CASE 
            WHEN income < 20000 THEN "Low Salary"
            WHEN income BETWEEN 20000 AND 50000 THEN "Average Salary"
            ELSE "High Salary"
        END AS category
    FROM Accounts
)
SELECT cte1.category, COUNT(cte2.category) AS accounts_count
FROM cte1
LEFT JOIN cte2
ON cte1.category = cte2.category
GROUP BY cte1.category;