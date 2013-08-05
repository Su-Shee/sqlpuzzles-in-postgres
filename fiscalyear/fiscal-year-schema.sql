-- psql -U postgres -d sqlpuzzles < fiscal-year-schema.sql

CREATE TABLE fiscalyear (
  fiscal_year SMALLINT NOT NULL,
  start_date DATE NOT NULL,
    CONSTRAINT valid_start_date 
      CHECK (start_date < end_date AND
            (EXTRACT (DAY FROM start_date)) = 01 AND 
            (EXTRACT (MONTH FROM start_date)) IN (01, 04, 07, 10)),
  end_date DATE NOT NULL,
    CONSTRAINT valid_start_end_year
      CHECK ((EXTRACT (YEAR FROM end_date)) = fiscal_year AND
             (EXTRACT (YEAR FROM start_date)) = fiscal_year),

  PRIMARY KEY (fiscal_year, start_date, end_date)
);


