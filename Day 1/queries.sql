-- 1. What is the total amount each customer spent at the restaurant?
SELECT customer_id, SUM(m.price) AS money_spent
FROM sales s JOIN menu m ON s.product_id = m.product_id
GROUP BY customer_id;
-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) AS days_visited
FROM sales
GROUP BY customer_id;
-- 3. What was the first item from the menu purchased by each customer?
WITH temp1 AS
(
	SELECT customer_id, order_date, m.product_name AS menu_item
	FROM sales s JOIN menu m ON s.product_id = m.product_id
),
temp2 AS
(
	SELECT *, DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) AS d_rank
	FROM temp1
)
SELECT DISTINCT customer_id, menu_item
FROM temp2
WHERE d_rank = 1;
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT m.product_name AS Item, COUNT(1) AS Total_no_of_purchase
FROM sales s JOIN menu m USING(product_id)
GROUP BY product_name
ORDER BY Total_no_of_purchase DESC
LIMIT 1;
-- 5. Which item was the most popular for each customer?
WITH temp AS
(
	SELECT s.customer_id, s.product_id, m.product_name AS Item, COUNT(1) AS cnt
	FROM sales s JOIN menu m USING(product_id)
	GROUP BY s.customer_id, s.product_id, m.product_name
	ORDER BY s.customer_id, cnt DESC
),
temp2 AS
(
	SELECT *, DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY cnt DESC) AS d_rank
	FROM temp
)
SELECT customer_id, Item AS Fav_Item, cnt AS no_of_orders
FROM temp2
WHERE d_rank = 1;
-- 6. Which item was purchased first by the customer after they became a member?
WITH temp AS
(
	SELECT s.*, m.join_date, DATEDIFF(s.order_date,m.join_date) AS diff
	FROM sales s JOIN members m 
	ON s.customer_id = m.customer_id AND DATEDIFF(s.order_date,m.join_date) >= 0
),
temp2 AS
(
	SELECT *,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY diff) AS d_rank
	FROM temp
)
SELECT customer_id, join_date, order_date, t.product_id, product_name
FROM temp2 t JOIN menu m ON t.product_id = m.product_id
WHERE d_rank = 1
ORDER BY customer_id;
-- 7. Which item was purchased just before the customer became a member?
WITH temp AS
(
	SELECT s.*, m.join_date, DATEDIFF(s.order_date,m.join_date) AS diff
	FROM sales s JOIN members m 
	ON s.customer_id = m.customer_id AND DATEDIFF(s.order_date,m.join_date) < 0
),
temp2 AS
(
	SELECT *,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY diff DESC) AS d_rank
	FROM temp
)
SELECT customer_id, join_date, order_date, t.product_id, product_name
FROM temp2 t JOIN menu m ON t.product_id = m.product_id
WHERE d_rank = 1
ORDER BY customer_id;
-- 8. What is the total items and amount spent for each member before they became a member?
SELECT s.customer_id, COUNT(s.product_id) AS No_of_Items, SUM(m2.price) AS Total_Spent
FROM sales s 
	JOIN members m1 ON s.customer_id = m1.customer_id AND s.order_date < m1.join_date
    JOIN menu m2 ON s.product_id = m2.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - 
-- how many points would each customer have?
WITH temp AS
(
	SELECT s.customer_id, m.product_name, SUM(m.price) AS Total_Spent
	FROM sales s JOIN menu m
	ON s.product_id = m.product_id
	GROUP BY s.customer_id, m.product_name
)
SELECT *,
	(CASE
		WHEN product_name = 'Sushi' THEN 2*(Total_Spent*10) 
        ELSE (Total_Spent*10)
	END) AS Reward_Points
FROM temp;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points 
-- on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT d.customer_id, 
SUM(CASE
	WHEN datediff(d.order_date, d.join_date) BETWEEN 0 AND 7 THEN 2*(d.price*10)
    ELSE (d.price*10)
END) AS Reward_Points
FROM
(
	SELECT s.customer_id, s.order_date, m1.join_date, m2.product_name, m2.price
	FROM sales s JOIN members m1 
	ON s.customer_id = m1.customer_id AND s.order_date >= m1.join_date
	JOIN menu m2 USING(product_id)
	WHERE MONTH(order_date) = 1
	ORDER BY customer_id
) d
GROUP BY d.customer_id
ORDER BY d.customer_id;