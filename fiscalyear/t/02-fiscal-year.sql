-- pg_prove -U postgres -d sqlpuzzles 02-fiscal-year.sql --verbose
-- psql -U postgres -h 10.13.2.47 -d sqlpuzzles -Xf 02-fiscal-year.sql

BEGIN;

SELECT plan(9);

SELECT lives_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2010-01-01$$, $$2010-12-31$$);',
  'inserting yearly interval should be ok'
);

SELECT lives_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2010-01-01$$, $$2010-03-31$$);',
  'inserting a quarterly interval should be ok'
);

SELECT throws_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2470, $$2470-17-44$$, $$2470-18-33$$);',
  'date/time field value out of range: "2470-17-44"',
  'inserting a bogus date should throw date/time field out of range'
);

SELECT throws_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2010-01-01$$, $$2010-12-31$$);',
  'duplicate key value violates unique constraint "fiscalyear_pkey"',
  'inserting the same interval should throw violate unique key constraint'
);

SELECT throws_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2010-04-01$$, $$2010-01-31$$);',
  'new row for relation "fiscalyear" violates check constraint "valid_start_date"',
  'inserting earlier start date than end date should violate check constraint'
);

SELECT throws_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2011-01-01$$, $$2010-12-31$$);',
  'new row for relation "fiscalyear" violates check constraint "valid_start_end_year"',
  'inserting different start year than fiscal year should violate check constraint'
);

SELECT throws_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2010-01-01$$, $$2011-12-31$$);',
  'new row for relation "fiscalyear" violates check constraint "valid_start_end_year"',
  'inserting different end year than fiscal year should violate check constraint'
);

SELECT throws_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2010-01-05$$, $$2010-12-31$$);',
  'new row for relation "fiscalyear" violates check constraint "valid_start_date"',
  'inserting a start date not starting with day 01 should violate check constraint'
);

SELECT throws_ok(
  'INSERT INTO 
    fiscalyear (fiscal_year, start_date, end_date)
  VALUES 
    (2010, $$2010-08-01$$, $$2010-12-31$$);',
  'new row for relation "fiscalyear" violates check constraint "valid_start_date"',
  'inserting a start date with month other than 01, 04, 07 or 10 should violate check constraint'
);

SELECT * FROM finish();
ROLLBACK;

