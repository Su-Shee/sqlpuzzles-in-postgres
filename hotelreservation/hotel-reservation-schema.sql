-- psql -U postgres -d sqlpuzzles < hotel-reservation-schema.sql

CREATE TABLE hotel (
  room INTEGER NOT NULL,
  arrival DATE NOT NULL,
  departure DATE NOT NULL,
  CONSTRAINT arrive_before_depart CHECK (arrival <= departure),
  guest TEXT NOT NULL,
  PRIMARY KEY(room, arrival)
);

CREATE TRIGGER double_booking AFTER INSERT OR UPDATE ON hotel
FOR EACH ROW EXECUTE PROCEDURE prevent_double_booking();

CREATE OR REPLACE FUNCTION prevent_double_booking() RETURNS TRIGGER AS
$$ 
BEGIN
  IF EXISTS (SELECT guest, arrival, departure 
    FROM hotel 
    WHERE NEW.arrival = departure AND NEW.room = room) 
    -- TIMESTAMP NEW.arrival = departure day AND NEW.arrival before 11
  THEN 
    RAISE EXCEPTION 'new row for relation "hotel" violates trigger double_booking';
  END IF;
  RETURN NULL;
END; 
$$ 
LANGUAGE plpgsql;

