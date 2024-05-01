
-- Solution 1: Using sub-query
/*
SELECT product_id,
       year AS first_year,
       quantity,
       price
FROM Sales
WHERE (product_id, year) IN
(SELECT
    product_id,
    MIN(year)
FROM Sales
GROUP BY product_id);
*/

-- Solution 2: Using window-function
/*
-- SELECT product_id,
--        year AS first_year,
--        quantity,
--        price
-- FROM
-- (
--     SELECT *,
--         RANK() OVER(PARTITION BY product_id ORDER BY year) AS rnk
--     FROM Sales
-- ) d
-- WHERE d.rnk = 1;
*/

-- Solution 3: Using Join
SELECT s.product_id, s.year AS first_year, s.quantity, s.price
FROM Sales s
JOIN
(
    SELECT
        product_id,
        MIN(year) AS first_sales_year
    FROM Sales
    GROUP BY product_id
) d
ON s.product_id = d.product_id
AND s.year = d.first_sales_year;