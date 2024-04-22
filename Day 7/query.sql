SELECT * FROM tasks;

SELECT 
	project_id, 
	GROUP_CONCAT(e.emp_id) AS EmpID,
	GROUP_CONCAT(' ',emp_name) AS EmpNames
FROM tasks t
JOIN employees e ON e.emp_id = t.emp_id
GROUP BY project_id;