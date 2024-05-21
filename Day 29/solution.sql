WITH cte AS
(SELECT Team1,
	CASE WHEN Winner = Team1 THEN 1 ELSE 0 END AS points
FROM cricket_matches
UNION ALL
SELECT Team2,
	CASE WHEN Winner = Team2 THEN 1 ELSE 0 END AS points
FROM cricket_matches)

SELECT Team1,
	COUNT(points) AS total_matches_played,
	SUM(CASE WHEN points = 1 THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN points = 0 THEN 1 ELSE 0 END) AS losses
FROM cte
GROUP BY Team1;