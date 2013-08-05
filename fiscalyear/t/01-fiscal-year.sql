-- pg_prove -U postgres -d sqlpuzzles 01-fiscal-year.sql --verbose
-- psql -U postgres -h 10.13.2.47 -d sqlpuzzles -Xf 01-fiscal-year.sql

BEGIN;

SELECT plan(11);

SELECT has_table('fiscalyear');
SELECT has_pk('fiscalyear');

SELECT has_column('fiscalyear', 'fiscal_year');
SELECT has_column('fiscalyear', 'start_date');
SELECT has_column('fiscalyear', 'end_date');

SELECT col_not_null('fiscalyear', 'fiscal_year');
SELECT col_not_null('fiscalyear', 'start_date');
SELECT col_not_null('fiscalyear', 'end_date');

SELECT col_type_is('fiscalyear', 'fiscal_year', 'smallint');
SELECT col_type_is('fiscalyear', 'start_date', 'date');
SELECT col_type_is('fiscalyear', 'end_date', 'date');

SELECT * FROM finish();
ROLLBACK;
