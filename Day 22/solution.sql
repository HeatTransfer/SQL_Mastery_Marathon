-- # Write your MySQL query statement below

WITH cte1 AS
(
    SELECT visited_on,
           SUM(amount) AS total
    FROM Customer
    GROUP BY visited_on
),
cte2 AS
(
    SELECT *,
        SUM(total) OVER(ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        AVG(total) OVER(ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS average_amount
    FROM cte1
)
SELECT visited_on,
    amount,
    ROUND(average_amount,2) AS average_amount
FROM cte2
WHERE DATE_ADD(visited_on, INTERVAL -6 DAY) IN (SELECT visited_on FROM cte1);

-- ===========================================================================
/* Solution 2 */
-- ===========================================================================

WITH cte AS (
    SELECT visited_on,
       SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
)
SELECT t1.visited_on,
    SUM(t2.amount) AS amount,
    ROUND(AVG(t2.amount), 2) AS average_amount
FROM cte t1
JOIN cte t2
ON t1.visited_on >= t2.visited_on
WHERE DATEDIFF(t1.visited_on, t2.visited_on) BETWEEN 0 AND 6
AND t1.visited_on >= (SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY) FROM Customer)
GROUP BY t1.visited_on;