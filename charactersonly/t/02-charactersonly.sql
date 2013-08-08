-- pg_prove -U postgres -d sqlpuzzles 02-charactersonly.sql --verbose
-- psql -U postgres -h 10.13.2.47 -d sqlpuzzles -Xf 02-charactersonly.sql

BEGIN;

SELECT plan(4);

SELECT throws_ok(
  'INSERT INTO 
    sometext (textdata)
  VALUES 
    ($$hottehüh8tralala$$);',
  'new row for relation "sometext" violates check constraint "characters_only"',
  'inserting numbers should violate check constraint'
);

SELECT throws_ok(
  'INSERT INTO 
    sometext (textdata)
  VALUES 
    ($$hottehüh Schubidu$$);',
  'new row for relation "sometext" violates check constraint "characters_only"',
  'inserting spaces should violate check constraint'
);

SELECT throws_ok(
  'INSERT INTO 
    sometext (textdata)
  VALUES 
    ($$Lalala?$_sdfj$$);',
  'new row for relation "sometext" violates check constraint "characters_only"',
  'inserting anything else but characters should violate check constraint'
);

SELECT lives_ok(
  'INSERT INTO 
    sometext (textdata)
  VALUES 
    ($$Schubdudelödeitralalala$$);',
  'inserting characters only with umlauts included should be ok'
);

SELECT * FROM finish();
ROLLBACK;

