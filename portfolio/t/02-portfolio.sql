-- pg_prove -U postgres -d sqlpuzzles 02-portfolio.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 02-portfolio.sql

BEGIN;

SELECT plan(14);

SELECT has_table('succession');
SELECT has_pk('succession');

SELECT has_column('succession', 'portfolio_id');
SELECT has_column('succession', 'next');
SELECT has_column('succession', 'chain');
SELECT has_column('succession', 'date');

SELECT col_not_null('succession', 'portfolio_id');
SELECT col_not_null('succession', 'chain');
SELECT col_not_null('succession', 'next');
SELECT col_not_null('succession', 'date');

SELECT col_type_is('succession', 'portfolio_id', 'integer');
SELECT col_type_is('succession', 'chain', 'integer');
SELECT col_type_is('succession', 'next', 'integer');
SELECT col_type_is('succession', 'date', 'date');

SELECT * FROM finish();
ROLLBACK;
