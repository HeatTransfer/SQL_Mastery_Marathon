USE danny_diner_case1;

/*-----------Additional Problem 1 ------------*/
SELECT 
    s.customer_id,
    s.order_date,
    m1.product_name,
    m1.price,
    (CASE
        WHEN
            s.order_date >= m2.join_date
        THEN
            CASE
                WHEN s.customer_id = m2.customer_id THEN 'Y'
            END
        ELSE 'N'
    END) AS member
FROM
    sales s
        JOIN
    menu m1 USING (product_id)
        LEFT JOIN
    members m2 ON s.customer_id = m2.customer_id;
    
/*-----------Additional Problem 2 ------------*/    
WITH temp AS
(
	SELECT 
		s.customer_id,
		s.order_date,
		m1.product_name,
		m1.price,
		(CASE
			WHEN
				s.order_date >= m2.join_date
			THEN
				CASE
					WHEN s.customer_id = m2.customer_id THEN 'Y'
				END
			ELSE 'N'
		END) AS member
	FROM
		sales s
			JOIN
		menu m1 USING (product_id)
			LEFT JOIN
		members m2 ON s.customer_id = m2.customer_id
)
SELECT *, 
(CASE
	WHEN temp.member = 'N' THEN NULL
    ELSE DENSE_RANK() OVER(PARTITION BY temp.customer_id, temp.member ORDER BY temp.order_date)		
END) AS ranking
FROM temp
ORDER BY customer_id;
