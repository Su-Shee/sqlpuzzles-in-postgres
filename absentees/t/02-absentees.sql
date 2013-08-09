-- pg_prove -U postgres -d sqlpuzzles 02-absentees-tables.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 02-absentees-tables.sql

BEGIN;

SELECT plan(14);

SELECT has_table('absence');
SELECT has_pk('absence');

SELECT has_column('absence', 'reason');
SELECT has_column('absence', 'absence_date');
SELECT has_column('absence', 'severity');
SELECT has_column('absence', 'employee');

SELECT col_not_null('absence', 'reason');
SELECT col_not_null('absence', 'absence_date');
SELECT col_not_null('absence', 'severity');
SELECT col_not_null('absence', 'employee');

SELECT col_type_is('absence', 'reason', 'text');
SELECT col_type_is('absence', 'absence_date', 'date');
SELECT col_type_is('absence', 'severity', 'smallint');
SELECT col_type_is('absence', 'employee', 'integer');

SELECT * FROM finish();
ROLLBACK;
