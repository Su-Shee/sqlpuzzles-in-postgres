-- pg_prove -U postgres -d sqlpuzzles 01-securitybadges.sql --verbose
-- psql -U postgres -h 10.13.2.47 -d sqlpuzzles -Xf 01-securitybadges.sql

BEGIN;

SELECT plan(24);

SELECT has_table('employees');
SELECT has_pk('employees');

SELECT has_column('employees', 'id');
SELECT has_column('employees', 'name');

SELECT col_not_null('employees', 'id');
SELECT col_not_null('employees', 'name');

SELECT col_type_is('employees', 'id', 'integer');
SELECT col_type_is('employees', 'name', 'text');

SELECT has_table('badges');
SELECT has_pk('badges');

SELECT triggers_are('public', 'badges', ARRAY['badge_status']);
SELECT trigger_is('public', 'badges', 'badge_status', 'public', 'invalidate_badge', 'Trigger invalidates all badges but current one');

SELECT has_column('badges', 'badge');
SELECT has_column('badges', 'employee');
SELECT has_column('badges', 'issued');
SELECT has_column('badges', 'status');

SELECT col_not_null('badges', 'badge');
SELECT col_not_null('badges', 'employee');
SELECT col_not_null('badges', 'issued');
SELECT col_not_null('badges', 'status');

SELECT col_type_is('badges', 'badge', 'integer');
SELECT col_type_is('badges', 'employee', 'integer');
SELECT col_type_is('badges', 'issued', 'date');
SELECT col_type_is('badges', 'status', 'character(1)');

SELECT * FROM finish();
ROLLBACK;
