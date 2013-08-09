-- pg_prove -U postgres -d sqlpuzzles 01-absentees-tables.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 01-absentees-tables.sql

BEGIN;

SELECT plan(5);

SELECT has_table('personell');
SELECT has_pk('personell');

SELECT has_column('personell', 'employee_id');

SELECT col_not_null('personell', 'employee_id');

SELECT col_type_is('personell', 'employee_id', 'integer');

SELECT * FROM finish();
ROLLBACK;
