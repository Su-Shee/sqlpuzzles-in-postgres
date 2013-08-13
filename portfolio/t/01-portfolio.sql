-- pg_prove -U postgres -d sqlpuzzles 01-portfolio.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 01-portfolio.sql

BEGIN;

SELECT plan(8);

SELECT has_table('portfolios');
SELECT has_pk('portfolios');

SELECT has_column('portfolios', 'id');
SELECT has_column('portfolios', 'stuff');

SELECT col_not_null('portfolios', 'id');
SELECT col_not_null('portfolios', 'stuff');

SELECT col_type_is('portfolios', 'id', 'integer');
SELECT col_type_is('portfolios', 'stuff', 'text');

SELECT * FROM finish();
ROLLBACK;
