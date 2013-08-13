-- pg_prove -U postgres -d sqlpuzzles 02-portfolio.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 02-portfolio.sql

BEGIN;

SELECT plan(3);

PREPARE most_current_portfolio AS
  SELECT 
    DISTINCT P.id, stuff, date 
  FROM 
    portfolios AS P 
  JOIN 
    succession AS S 
  ON 
    P.id = S.portfolio_id 
  WHERE 
    next = (SELECT 
              max(next) 
            FROM 
              succession 
            AS 
              S2 
            WHERE S.chain = S2.chain);

SELECT results_eq (
  'most_current_portfolio',
  $$VALUES(10::integer, 'lemon'::text, '2012-11-04'::date)$$,
  'should be able to select most current portfolio'
);

PREPARE trail_portfolios AS
  SELECT 
    chain, next, P.id, S.date 
  FROM 
    portfolios AS P 
  JOIN 
    succession AS S 
  ON 
    S.portfolio_id = P.id 
  WHERE 
    chain = 1 
  ORDER BY 
    chain, next;

SELECT results_eq (
  'trail_portfolios',
  $$VALUES
    (1::integer, 0::integer, 1::integer, '2012-10-17'::date),
    (1::integer, 1::integer, 2::integer, '2012-10-18'::date),
    (1::integer, 2::integer, 3::integer, '2012-10-19'::date),
    (1::integer, 3::integer, 4::integer, '2012-11-02'::date),
    (1::integer, 4::integer,10::integer, '2012-11-04'::date)
  $$,
  'should show the trail of portfolios in succession'
);

PREPARE superseded_portfolio AS
  SELECT 
    S.portfolio_id, S2.portfolio_id, S2.date 
  FROM 
    succession AS S 
  JOIN 
    succession AS S2 
  ON 
    S.chain = S2.chain 
  WHERE 
    S.next = S2.next + 1 AND S.portfolio_id = 4;

SELECT results_eq (
  'superseded_portfolios',
  $$VALUES(4::integer, 3::integer, '2012-10-19'::date)$$,
  'should return the portfolio superseded by this one'
);

SELECT * FROM finish();
ROLLBACK;

