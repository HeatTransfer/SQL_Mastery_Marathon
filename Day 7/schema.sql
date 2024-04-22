CREATE TABLE departments (
	id INT,
    name VARCHAR(20)
);

INSERT INTO departments
VALUES (1, 'Sales'), (2, 'Marketing');

CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT
);

INSERT INTO employees (emp_id, emp_name, salary, dept_id)
VALUES
    (1, 'Alice', 50000, 1),
    (2, 'Bob', 60000, 2),
    (3, 'Charlie', 45000, 1),
    (4, 'David', 70000, 2),
    (5, 'Eve', 55000, 1),
    (6, 'Frank', 65000, 2),
    (7, 'Grace', 48000, 1),
    (8, 'Henry', 72000, 2);
    
CREATE TABLE projects (
    project_id INT,
    project_name VARCHAR(50),
    budget INT,
    dept_id INT
);

INSERT INTO projects (project_id, project_name, budget, dept_id)
VALUES
    (101, 'ProjectA', 50000, 1),
    (102, 'ProjectB', 60000, 2),
    (103, 'ProjectC', 45000, 1),
    (104, 'ProjectD', 70000, 2),
    (105, 'ProjectE', 55000, 1),
    (106, 'ProjectF', 65000, 2),
    (107, 'ProjectG', 48000, 1),
    (108, 'ProjectH', 72000, 2);

CREATE TABLE tasks (
    task_id INT,
    task_name VARCHAR(50),
    emp_id INT,
    project_id INT
);

INSERT INTO tasks (task_id, task_name, emp_id, project_id)
VALUES
    (201, 'TaskA', 1, 101),
    (202, 'TaskB', 2, 102),
    (203, 'TaskC', 1, 103),
    (204, 'TaskD', 4, 102),
    (205, 'TaskE', 3, 101),
    (206, 'TaskF', 1, 105),
    (207, 'TaskG', 3, 107),
    (208, 'TaskH', 6, 106),
    (209, 'TaskI', 2, 104),
    (210, 'TaskJ', 7, 108),
    (211, 'TaskK', 1, 105),
    (212, 'TaskL', 5, 103),
    (213, 'TaskM', 3, 106),
    (214, 'TaskN', 4, 104),
    (215, 'TaskO', 5, 108);
