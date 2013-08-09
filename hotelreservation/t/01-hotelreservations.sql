-- pg_prove -U postgres -d sqlpuzzles 01-hotelreservations.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 01-hotelreservations.sql

BEGIN;

SELECT plan(17);

SELECT has_table('hotel');
SELECT has_pk('hotel');

SELECT triggers_are('public', 'hotel', ARRAY['double_booking']); 
SELECT trigger_is('public', 'hotel', 'double_booking', 'public', 'prevent_double_booking', 'Trigger prevents double booking a room'); 


SELECT has_column('hotel', 'room');
SELECT has_column('hotel', 'guest');
SELECT has_column('hotel', 'arrival');
SELECT has_column('hotel', 'departure');

SELECT col_not_null('hotel', 'room');
SELECT col_not_null('hotel', 'guest');
SELECT col_not_null('hotel', 'arrival');
SELECT col_not_null('hotel', 'departure');

SELECT col_type_is('hotel', 'room', 'integer');
SELECT col_type_is('hotel', 'guest', 'text');
SELECT col_type_is('hotel', 'arrival', 'date');
SELECT col_type_is('hotel', 'departure', 'date');

SELECT has_check('public', 'hotel', 'table should have a check constraint');

SELECT * FROM finish();
ROLLBACK;
