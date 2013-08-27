INSERT INTO departments (department_id, department) VALUES
(1, 'Tech'), 
(2, 'Human Ressources'), 
(3, 'Sales'), 
(4, 'Marketing'),
(5, 'Finance');

INSERT INTO employees (employee_id, department_id, boss_id, name, salary) VALUES
(1, 1, 0, 'manager 1', 80000), 
(2, 2, 0, 'manager 2', 85000), 
(3, 4, 1, 'employer 1', 60000), 
(4, 3, 1, 'employer 2', 50000), 
(5, 3, 1, 'employer 3', 95000), 
(6, 4, 1, 'employer 4', 75000);

