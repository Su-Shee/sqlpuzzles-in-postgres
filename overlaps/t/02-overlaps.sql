-- pg_prove -U postgres -d sqlpuzzles 02-overlaps.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 02-overlaps.sql

BEGIN;

SELECT plan(1);

PREPARE show_operations AS
  SELECT op1 
  AS 
    procedure_id, max(total) 
  AS 
    max_inst_count 
  FROM 
    overlapping_operations 
  GROUP BY 
    op1
  LIMIT 2;

SELECT results_eq (
  'show_operations',
  $$VALUES(80::integer, 1::bigint),
          (30::integer, 3::bigint)$$,
  'select should list the number of overlapping operations'
);

SELECT * FROM finish();
ROLLBACK;

