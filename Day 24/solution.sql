SELECT COUNT(*) AS present_inside_hospital FROM hospital
WHERE (emp_id, `time`) IN (
	SELECT emp_id, MAX(`time`) 
	FROM hospital
	GROUP BY emp_id)
AND `action` = 'in';