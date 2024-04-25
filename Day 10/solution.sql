SELECT m.name
FROM Employee e
JOIN Employee m
ON e.managerId = m.id
GROUP BY e.managerId, m.name
HAVING COUNT(e.id) >= 5;