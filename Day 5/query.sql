SELECT customer_id
FROM (
    SELECT customer_id, COUNT(DISTINCT product_key) AS cnt
    FROM customer
    GROUP BY customer_id
) d
WHERE d.cnt = (SELECT COUNT(product_key) FROM product);
