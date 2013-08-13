-- psql -U postgres -d sqlpuzzles < portfolio.sql

CREATE TABLE portfolios (
  id INTEGER UNIQUE NOT NULL,
  stuff TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE succession (
  chain INTEGER NOT NULL,
  next INTEGER NOT NULL DEFAULT 0 CHECK (next >= 0),
  date DATE NOT NULL,
  portfolio_id INTEGER NOT NULL REFERENCES portfolios(id),
  PRIMARY KEY (chain, next)
);

--CREATE TRIGGER badge_status AFTER INSERT OR UPDATE ON badges
--FOR EACH ROW EXECUTE PROCEDURE invalidate_badge();
--
--CREATE OR REPLACE FUNCTION invalidate_badge() RETURNS TRIGGER AS
--$$ 
--BEGIN
--  UPDATE badges SET status = 'I' WHERE NEW.employee = employee AND issued < NEW.issued;
----    FROM (SELECT B1.employee, B1.status, B1.issued 
----      FROM (SELECT employee, issued, status 
----            FROM badges 
----            WHERE employee = NEW.employee 
----            EXCEPT 
----            SELECT employee, MAX(issued), status FROM badges GROUP BY employee, status) 
----            AS B1) 
----      AS B2 WHERE B2.employee = badges.employee AND B2.issued = badges.issued;
--  RETURN NEW;
--END; 
--$$ 
--LANGUAGE plpgsql;
--
