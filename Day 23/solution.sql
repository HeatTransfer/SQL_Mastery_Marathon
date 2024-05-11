# Write your MySQL query statement below

WITH cte AS (
    SELECT requester_id,
       COUNT(requester_id) AS frnd
    FROM RequestAccepted
    GROUP BY requester_id
        UNION ALL
    SELECT accepter_id,
       COUNT(accepter_id)
    FROM RequestAccepted
    GROUP BY accepter_id
)
SELECT requester_id AS id,
    SUM(frnd) AS num
FROM cte
GROUP BY id
ORDER BY num DESC LIMIT 1;