-- pg_prove -U postgres -d sqlpuzzles 03-absentees-tables.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 03-absentees-tables.sql

-- isn't able to see weekends in between when calculating sick days
-- public holidays cannot be sickdays - helper table?
-- data cannot be before employee even started
-- sickdays calculated within a year

BEGIN;

SELECT plan(6);

SELECT throws_ok(
  'INSERT INTO 
    absence (employee, reason, absence_date, severity) 
  VALUES 
    (0011, $$unexcused$$, $$2012-07-22$$, 4);',
  'new row for relation "absence" violates check constraint "absence_absence_date_check"',
  'inserting a sunday as sickday should throw violate check constraint error'
);

SELECT throws_ok(
  'INSERT INTO 
    absence (employee, reason, absence_date, severity) 
  VALUES 
    (0011, $$unexcused$$, $$2012-07-21$$, 4);',
  'new row for relation "absence" violates check constraint "absence_absence_date_check"',
  'inserting a saturday as sickday should throw violate check constraint error'
);

SELECT lives_ok(
  'INSERT INTO 
    absence (employee, reason, absence_date, severity) 
  VALUES 
    (9, $$another sickday$$, $$2012-03-23$$, 0);',
  'insert a new sickday should be ok'
);

PREPARE sickday_trigger AS
  SELECT severity, reason
  FROM absence
  WHERE employee = 9 AND absence_date = '2012-03-22';

SELECT results_eq (
  'sickday_trigger',
  $$VALUES(0::smallint, 'trigger long term illness'::text)$$,
  'for previous day severity should be changed to 0, reason trigger long term illness'
);

SELECT lives_ok(
  'UPDATE 
    absence 
  SET 
    severity = 0, reason = $$truely really ill$$ 
  WHERE 
    employee = 9 AND absence_date = ($$2012-08-18$$::date - interval $$1 day$$);',
  'update severity to 0 should just work'
);

PREPARE update_to_sickday AS
  SELECT severity, reason
  FROM absence
  WHERE employee = 9 AND absence_date = '2012-08-17';

SELECT results_eq (
  'update_to_sickday',
  $$VALUES(0::smallint, 'truely really ill'::text)$$,
  'previous day should be updated to severity 0 and reason truely ill'
);

SELECT * FROM finish();
ROLLBACK;
