WITH cte1 AS
(SELECT MONTH(record_date) AS rec_month,
	   SUM(cases_count) AS total_cases
FROM covid_cases
GROUP BY rec_month),

cte2 AS
(SELECT curr_month.rec_month, 
curr_month.total_cases, IFNULL(SUM(prev_month.total_cases),0) AS cum_sum
FROM cte1 curr_month
LEFT JOIN cte1 prev_month
ON curr_month.rec_month > prev_month.rec_month
GROUP BY curr_month.rec_month, curr_month.total_cases)

SELECT rec_month AS 'Month', 
	   ROUND(IFNULL(total_cases/cum_sum, 0)*100,2) AS '%increase'
FROM cte2;
