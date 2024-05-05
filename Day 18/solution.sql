WITH temp AS
(   
    SELECT *,
        DATEDIFF('2019-08-16', change_date) AS diff
    FROM Products
)
SELECT 
    DISTINCT t.product_id, 
    CASE WHEN d.min_diff IS NULL THEN 10 ELSE new_price END AS price
FROM temp t
LEFT JOIN(
    SELECT product_id, MIN(diff) AS min_diff
    FROM temp
    WHERE diff >= 0
    GROUP BY product_id
) d
ON t.product_id = d.product_id
WHERE t.diff = d.min_diff OR d.min_diff IS NULL;