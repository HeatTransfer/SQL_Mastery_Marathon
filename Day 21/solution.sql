-- # Write your MySQL query statement below

-- Solution 1

WITH cte1 AS
(
    SELECT user_id, COUNT(movie_id) AS no_of_movies
    FROM MovieRating
    GROUP BY user_id
),
cte2 AS
(
    SELECT movie_id, AVG(rating) AS avg_rating
    FROM MovieRating mr
    WHERE DATE_FORMAT(mr.created_at, '%Y-%m') = '2020-02'
    GROUP BY movie_id
)
SELECT * FROM
(
    (SELECT u.name AS results
        FROM cte1 t1
        JOIN Users u ON t1.user_id = u.user_id
        AND t1.no_of_movies = (SELECT MAX(no_of_movies) FROM cte1)
        ORDER BY u.name LIMIT 1)
    UNION ALL
    (SELECT m.title
        FROM cte2 t2
        JOIN Movies m ON t2.movie_id = m.movie_id
        AND t2.avg_rating = (SELECT MAX(avg_rating) FROM cte2)
        ORDER BY m.title LIMIT 1)
) d;

-- Solution 2

    (SELECT u.name AS results
    FROM MovieRating mr
    JOIN Users u
    ON mr.user_id = u.user_id
    GROUP BY u.name
    ORDER BY COUNT(mr.movie_id) DESC, u.name
    LIMIT 1)
UNION ALL
    (SELECT m.title
    FROM MovieRating mr
    JOIN Movies m
    ON mr.movie_id = m.movie_id AND DATE_FORMAT(mr.created_at, '%Y-%m') = '2020-02'
    GROUP BY m.title
    ORDER BY AVG(mr.rating) DESC, m.title
    LIMIT 1)
