-- pg_prove -U postgres -d sqlpuzzles 04-moarjoins-tables.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 04-moarjoins-tables.sql

BEGIN;

SELECT plan(6);

PREPARE less_than_x_people_per_department AS 
  SELECT 
    count(E.employee_id) AS "people", 
    D.department 
  FROM 
    employees E 
  JOIN 
    departments D 
  ON 
    E.department_id = D.department_id 
  GROUP BY 
    E.department_id, D.department 
  HAVING 
    count(E.employee_id) < 3;

SELECT set_eq (
  'less_than_x_people_per_department',
  $$VALUES
  (2::bigint, 'Human Ressources'::text),
  (2::bigint, 'Tech'::text),
  (2::bigint, 'Sales'::text),
  (2::bigint, 'Marketing'::text)
  $$,
  'list departments with less than xx people'
);

PREPARE people_per_department AS 
  SELECT 
    D.department, 
    count(E.employee_id) AS "people" 
  FROM 
    departments D 
  LEFT JOIN 
    employees E 
  ON 
    D.department_id = E.department_id 
  GROUP BY 
    D.department 
  ORDER BY 
    people;

SELECT set_eq (
  'people_per_department',
  $$VALUES
  ('Finance'::text, 0::bigint),
  ('Human Ressources'::text, 2::bigint),
  ('Marketing'::text, 2::bigint),
  ('Sales'::text, 2::bigint),
  ('Tech'::text, 2::bigint)
  $$,
  'should list the number of people per department, empty included'
);

PREPARE have_no_boss AS
  SELECT 
    E.name, D.department 
  FROM 
    departments D 
  JOIN 
    employees E 
  ON 
    D.department_id = e.department_id 
  WHERE 
    E.department_id 
  NOT IN (
      SELECT 
        department_id 
      FROM 
        employees 
      WHERE 
        boss_id = 0
      );

SELECT set_eq (
  'have_no_boss',
  $$VALUES
  ('employer 1'::text, 'Marketing'::text),
  ('employer 2'::text, 'Sales'::text),
  ('employer 3'::text, 'Sales'::text),
  ('employer 4'::text, 'Marketing'::text)
  $$,
  'should list employees not having a boss in the same department'
);

PREPARE salary_total_per_department AS
  SELECT 
    d.department AS "Department", 
    sum(e.salary) AS "Total Salary" 
  FROM 
    departments d 
  LEFT JOIN 
    employees e 
  ON 
    d.department_id = e.department_id 
  GROUP BY 
    d.department_id;

SELECT set_eq (
  'salary_total_per_department',
  $$VALUES
  ('Finance'::text, NULL),                
  ('Human Ressources'::text, 150000::bigint),
  ('Marketing'::text, 135000::bigint),
  ('Tech'::text, 145000::bigint),
  ('Sales'::text, 145000::bigint)
  $$,
  'should list the salary total per department'
);


PREPARE higher_salary_than_boss AS
  SELECT 
    E1.name AS "Employee", 
    E2.name AS "Boss", 
    E1.salary AS "Employee Salary", 
    E2.salary AS "Boss Salary" 
  FROM (
    SELECT 
      name, salary 
    FROM 
      employees 
    WHERE boss_id = 1
  ) E1 
  JOIN 
    employees AS E2 
  ON 
    E1.salary > E2.salary 
  WHERE 
    boss_id = 0;

SELECT set_eq (
  'higher_salary_than_boss',
  $$VALUES
  ('employer 3'::text, 'manager 1'::text, 95000::integer, 80000::integer),
  ('employer 3'::text, 'manager 2'::text, 95000::integer, 85000::integer)
  $$,
  'should list employees having a higher salary than their boss'
);

PREPARE highest_pay_per_department AS
  SELECT 
    e.name AS "Highest Paid Employee", 
    d.department "Department" 
  FROM 
    employees e, 
    (SELECT 
      max(salary) AS salary, department_id 
     FROM 
      employees 
    GROUP BY 
      department_id) s, 
    departments d 
  WHERE 
    s.department_id = d.department_id AND 
    e.department_id = s.department_id AND 
    e.salary = s.salary;

SELECT set_eq (
  'highest_pay_per_department',
  $$VALUES
  ('employer 4'::text, 'Marketing'::text),
  ('manager 1'::text, 'Tech'::text),
  ('employer 3'::text, 'Sales'::text),
  ('manager 2'::text, 'Human Ressources'::text)
  $$,
  'should list the highest paid employee per department'
);

SELECT * FROM finish();
ROLLBACK;
