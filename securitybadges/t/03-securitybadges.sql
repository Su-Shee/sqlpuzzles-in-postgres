-- pg_prove -U postgres -d sqlpuzzles 02-securitybadges.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 02-securitybadges.sql

BEGIN;

SELECT plan(1);

INSERT INTO badges (employee, issued, status) VALUES (002, '2012-10-18', 'A');

PREPARE badges_invalid AS
  SELECT status, issued 
  FROM badges
  WHERE employee = 2
  ORDER BY issued;

SELECT results_eq (
  'badges_invalid',
  $$VALUES('I'::character(1), '2012-10-17'::date),
          ('A'::character(1), '2012-10-18'::date)$$,
  'only latest badge should be active'
);

SELECT * FROM finish();
ROLLBACK;

