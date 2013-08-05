-- psql -U postgres -d sqlpuzzles < overlaps-schema.sql

CREATE TABLE overlapping (
  operation INTEGER NOT NULL,
  anesthesist TEXT NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  PRIMARY KEY (operation, anesthesist)
);

CREATE VIEW 
  overlapping_operations (op1, op2, total) 
AS SELECT 
  P1.operation, P2.operation, count(*) 
FROM 
  overlapping AS P1, overlapping AS P2, overlapping AS P3 
WHERE 
  P2.anesthesist = P1.anesthesist 
AND 
  P3.anesthesist = P1.anesthesist
AND 
  P1.start_time <= P2.start_time
AND 
  P2.start_time < P1.end_time 
AND 
  P3.start_time <= P2.start_time 
AND 
  P2.start_time < P3.end_time 
GROUP BY 
  P1.operation, P2.operation;
