-- pg_prove -U postgres -d sqlpuzzles 03-moarjoins-tables.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 03-moarjoins-tables.sql

BEGIN;

SELECT plan(26);

SELECT has_table('employees');
SELECT has_pk('employees');

SELECT has_column('employees', 'employee_id');
SELECT has_column('employees', 'boss_id');
SELECT has_column('employees', 'department_id');
SELECT has_column('employees', 'name');
SELECT has_column('employees', 'salary');

SELECT col_not_null('employees', 'employee_id');
SELECT col_not_null('employees', 'name');
SELECT col_not_null('employees', 'boss_id');
SELECT col_not_null('employees', 'salary');
SELECT col_not_null('employees', 'department_id');

SELECT col_type_is('employees', 'employee_id', 'integer');
SELECT col_type_is('employees', 'name', 'text');
SELECT col_type_is('employees', 'boss_id', 'integer');
SELECT col_type_is('employees', 'salary', 'integer');
SELECT col_type_is('employees', 'department_id', 'integer');

SELECT col_is_fk('employees', 'department_id');

SELECT has_table('departments');
SELECT has_pk('departments');

SELECT has_column('departments', 'department_id');
SELECT has_column('departments', 'department');

SELECT col_not_null('departments', 'department_id');
SELECT col_not_null('departments', 'department');

SELECT col_type_is('departments', 'department_id', 'integer');
SELECT col_type_is('departments', 'department', 'text');

SELECT * FROM finish();
ROLLBACK;
