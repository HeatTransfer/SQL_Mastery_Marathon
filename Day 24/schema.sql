CREATE TABLE hospital ( 
	emp_id INT, 
    `action` VARCHAR(10), 
    `time` DATETIME
);

INSERT INTO hospital VALUES (1, 'in', '2019-12-22 09:00:00');
INSERT INTO hospital VALUES (1, 'out', '2019-12-22 09:15:00');
INSERT INTO hospital VALUES (2, 'in', '2019-12-22 09:00:00');
INSERT INTO hospital VALUES (2, 'out', '2019-12-22 09:15:00');
INSERT INTO hospital VALUES (2, 'in', '2019-12-22 09:30:00');
INSERT INTO hospital VALUES (3, 'out', '2019-12-22 09:00:00');
INSERT INTO hospital VALUES (3, 'in', '2019-12-22 09:15:00');
INSERT INTO hospital VALUES (3, 'out', '2019-12-22 09:30:00');
INSERT INTO hospital VALUES (3, 'in', '2019-12-22 09:45:00');
INSERT INTO hospital VALUES (4, 'in', '2019-12-22 09:45:00');
INSERT INTO hospital VALUES (5, 'out', '2019-12-22 09:40:00');