-- pg_prove -U postgres -d sqlpuzzles 02-hotelreservations.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 02-hotelreservations.sql

BEGIN;

SELECT plan(2);

INSERT INTO hotel (guest, room, arrival, departure) 
VALUES ('Schmidt', 2, '2013-11-08', '2013-11-20');

SELECT throws_ok(
  'INSERT INTO 
      hotel (guest, room, arrival, departure)
   VALUES 
      ($$Müller$$, 2, $$2013-11-20$$, $$2013-11-30$$);',
  'new row for relation "hotel" violates trigger double_booking',
  'inserting arrival on departure of the same room should raise exception'
);

SELECT throws_ok(
  'INSERT INTO 
    hotel (guest, room, arrival, departure)
   VALUES 
    ($$Müller$$, 2, $$2013-10-10$$, $$2013-10-08$$);',
  'new row for relation "hotel" violates check constraint "arrive_before_depart"',
  'inserting departure before arrival should violate check constraint'
);

SELECT * FROM finish();
ROLLBACK;

