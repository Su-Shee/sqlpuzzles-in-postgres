-- psql -U postgres -d sqlpuzzles < absentees-schema.sql

CREATE TABLE personell (
  employee_id INTEGER NOT NULL UNIQUE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE absence (
  employee INTEGER NOT NULL,
  FOREIGN KEY (employee) REFERENCES personell (employee_id) ON DELETE CASCADE,
  absence_date DATE NOT NULL CHECK ((EXTRACT (DOW from absence_date)) NOT IN (0, 6)),
  reason TEXT NOT NULL,
  severity SMALLINT NOT NULL CHECK (severity BETWEEN 0 AND 4),
  PRIMARY KEY (employee, absence_date)
);


CREATE TRIGGER sickday_changes_severity AFTER INSERT ON absence
FOR EACH ROW EXECUTE PROCEDURE change_severity();

CREATE OR REPLACE FUNCTION change_severity() RETURNS TRIGGER AS
$$ 
BEGIN
  UPDATE absence 
  SET severity = 0, reason = 'trigger long term illness' 
  WHERE employee = NEW.employee AND absence_date = (NEW.absence_date::date - interval '1 day');
  RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql;

