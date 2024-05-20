SELECT t1.id, t2.student FROM
(SELECT *,
    CASE
        WHEN id%2 = 0 THEN id - 1
        ELSE 
            CASE 
                WHEN id IN (SELECT MAX(id) FROM Seat) THEN id
                ELSE id+1
            END
    END AS new_id
FROM Seat) t1
JOIN Seat t2
ON t1.new_id = t2.id
ORDER BY t1.id;