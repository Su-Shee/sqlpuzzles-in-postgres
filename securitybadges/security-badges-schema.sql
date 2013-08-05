-- psql -U postgres -d sqlpuzzles < overlaps-schema.sql

CREATE TABLE employees (
  id INTEGER UNIQUE NOT NULL,
  name TEXT NOT NULL,
  PRIMARY KEY (id, name)
);

CREATE TABLE badges (
  badge SERIAL UNIQUE NOT NULL,
  employee INTEGER NOT NULL REFERENCES employees(id),
  issued DATE NOT NULL,
  status CHAR(1) NOT NULL CHECK (status IN ('I', 'A')),
  PRIMARY KEY (badge, employee)
);

CREATE TRIGGER badge_status AFTER INSERT OR UPDATE ON badges
FOR EACH ROW EXECUTE PROCEDURE invalidate_badge();

CREATE OR REPLACE FUNCTION invalidate_badge() RETURNS TRIGGER AS
$$ 
BEGIN
  UPDATE badges SET status = 'I' WHERE NEW.employee = employee AND issued < NEW.issued;
--    FROM (SELECT B1.employee, B1.status, B1.issued 
--      FROM (SELECT employee, issued, status 
--            FROM badges 
--            WHERE employee = NEW.employee 
--            EXCEPT 
--            SELECT employee, MAX(issued), status FROM badges GROUP BY employee, status) 
--            AS B1) 
--      AS B2 WHERE B2.employee = badges.employee AND B2.issued = badges.issued;
  RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql;

