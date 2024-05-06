-- Using Window function (running total)
WITH cte AS(
    SELECT *,
        SUM(weight) OVER(ORDER BY turn ASC) AS total_weight
    FROM Queue
)
SELECT person_name FROM cte
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;

-- Using self-join

SELECT person_name FROM Queue
WHERE turn = (
    SELECT q1.turn AS total_weight
    FROM Queue q1
    JOIN Queue q2
    ON q1.turn >= q2.turn
    GROUP BY q1.turn
    HAVING SUM(q2.weight) <= 1000
    ORDER BY SUM(q2.weight) DESC
    LIMIT 1
);