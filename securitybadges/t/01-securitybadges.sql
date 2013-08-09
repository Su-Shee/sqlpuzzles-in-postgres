-- pg_prove -U postgres -d sqlpuzzles 01-securitybadges.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 01-securitybadges.sql

BEGIN;

SELECT plan(8);

SELECT has_table('employees');
SELECT has_pk('employees');

SELECT has_column('employees', 'id');
SELECT has_column('employees', 'name');

SELECT col_not_null('employees', 'id');
SELECT col_not_null('employees', 'name');

SELECT col_type_is('employees', 'id', 'integer');
SELECT col_type_is('employees', 'name', 'text');

SELECT * FROM finish();
ROLLBACK;
