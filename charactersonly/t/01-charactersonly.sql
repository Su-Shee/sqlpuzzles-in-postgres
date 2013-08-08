-- pg_prove -U postgres -d sqlpuzzles 01-securitybadges.sql --verbose
-- psql -U postgres -h 10.13.2.47 -d sqlpuzzles -Xf 01-charactersonly.sql

BEGIN;

SELECT plan(5);

SELECT has_table('sometext');

SELECT has_column('sometext', 'textdata');

SELECT col_not_null('sometext', 'textdata');

SELECT col_type_is('sometext', 'textdata', 'text');

SELECT col_has_check('sometext', 'textdata', 'should have a check constraint for characters only');

SELECT * FROM finish();
ROLLBACK;
