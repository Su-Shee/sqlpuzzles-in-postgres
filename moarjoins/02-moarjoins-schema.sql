-- psql -U postgres -d sqlpuzzles < 02-moarjoins-schema.sql

CREATE TABLE departments (
  department_id INTEGER NOT NULL UNIQUE,
  department TEXT NOT NULL,
  PRIMARY KEY (department_id)
);

CREATE TABLE employees (
  employee_id INTEGER NOT NULL UNIQUE,
  department_id INTEGER NOT NULL REFERENCES departments(department_id),
  boss_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  salary integer NOT NULL,
  PRIMARY KEY (employee_id)
);

---- highest/lowest example
--CREATE TABLE salaries (
--);
--
---- previous/next example
--CREATE TABLE books (
--);
--
---- same city/country example
--CREATE TABLE friends (
--);
--
---- finding duplicates example
--
--CREATE TABLE duplicates (
--);
