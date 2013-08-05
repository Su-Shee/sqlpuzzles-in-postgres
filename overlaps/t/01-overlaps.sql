-- pg_prove -U postgres -d sqlpuzzles 01-overlapping.sql --verbose
-- pg_prove -U postgres -d sqlpuzzles 01-overlaps.sql --verbose
-- psql -U postgres -h 10.13.2.47 -d sqlpuzzles -Xf 01-overlaps.sql

BEGIN;

SELECT plan(15);

SELECT has_table('overlapping');
SELECT has_pk('overlapping');

SELECT has_column('overlapping', 'operation');
SELECT has_column('overlapping', 'anesthesist');
SELECT has_column('overlapping', 'start_time');
SELECT has_column('overlapping', 'end_time');

SELECT col_not_null('overlapping', 'operation');
SELECT col_not_null('overlapping', 'start_time');
SELECT col_not_null('overlapping', 'anesthesist');
SELECT col_not_null('overlapping', 'end_time');

SELECT col_type_is('overlapping', 'operation', 'integer');
SELECT col_type_is('overlapping', 'anesthesist', 'text');
SELECT col_type_is('overlapping', 'start_time', 'time without time zone');
SELECT col_type_is('overlapping', 'end_time', 'time without time zone');

SELECT views_are('public', ARRAY['overlapping_operations']);

SELECT * FROM finish();
ROLLBACK;
