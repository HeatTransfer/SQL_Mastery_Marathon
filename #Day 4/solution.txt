WITH temp AS
        (SELECT S.user_id,
            sum(
                CASE
                    WHEN action = 'timeout' THEN 1 ELSE 0
                end) AS timeout,
            sum(CASE
                    WHEN action = 'confirmed' THEN 1 ELSE 0
                end) AS confirmed
        FROM Signups S
        LEFT JOIN Confirmations C USING(user_id)
        GROUP BY S.user_id)
SELECT user_id, coalesce(ROUND((confirmed/(timeout+confirmed)),2),0) AS confirmation_rate
FROM temp;