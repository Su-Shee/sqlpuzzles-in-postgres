-- pg_prove -U postgres -d sqlpuzzles 02-moarjoins-tables.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 02-moarjoins-tables.sql

BEGIN;

SELECT plan(5);

PREPARE list_subjects_with_where AS
  SELECT 
    name, subject 
  FROM
    students AS S, 
    classes AS C, 
    subjects AS SJ 
  WHERE 
    S.student_id = C.student_id 
  AND 
    SJ.subject_id = C.subject_id
  AND 
    name = 'Babs Jensen'
  ORDER BY 
    subject;

SELECT results_eq (
  'list_subjects_with_where',
  $$VALUES
  ('Babs Jensen'::text, 'Chemie morgen'::text),
  ('Babs Jensen'::text, 'Partikel-Ökonomie'::text),
  ('Babs Jensen'::text, 'Philosophie ultrakrass'::text)
  $$,
  'should list all subjects of a student - old school where'
);

PREPARE list_subjects_with_join AS
  SELECT 
    name, subject 
  FROM 
    students AS S 
  JOIN 
    classes AS C 
  ON 
    S.student_id = C.student_id
  JOIN 
    subjects AS SJ 
  ON 
    C.subject_id = SJ.subject_id
  WHERE
    name = 'Babs Jensen' 
  ORDER BY 
    subject;

SELECT results_eq (
  'list_subjects_with_join',
  $$VALUES
  ('Babs Jensen'::text, 'Chemie morgen'::text),
  ('Babs Jensen'::text, 'Partikel-Ökonomie'::text),
  ('Babs Jensen'::text, 'Philosophie ultrakrass'::text)
  $$,
  'should list all subjects of a student - new school join'
);

PREPARE list_studentless_subjects AS
  SELECT 
    S.subject, count(C.student_id) 
  FROM 
    subjects AS S 
  LEFT JOIN 
    classes AS C 
  ON 
    S.subject_id = C.subject_id 
  GROUP BY 
    S.subject 
  ORDER BY 
    count
  LIMIT 4;

SELECT results_eq (
  'list_studentless_subjects',
  $$VALUES
  ('Empty class'::text, 0::bigint),
  ('Nobody here'::text, 0::bigint),
  ('Philosophie ultrakrass'::text, 2::integer),
  ('Chemie morgen'::text, 2::integer)
  $$,
  'should list all subjects along with the number of students - empty classes included'
);

PREPARE list_subjects_by_more_than AS
  SELECT 
    S.subject, count(C.student_id) 
  FROM 
    subjects AS S 
  LEFT JOIN 
    classes AS C 
  ON 
    S.subject_id = C.subject_id 
  GROUP BY 
    S.subject 
  HAVING 
    count(C.student_id) > 2; 

SELECT set_eq (
  'list_subjects_by_more_than',
  $$VALUES
  ('Really hard lecture'::text, 3::integer),
  ('Hardcore Math'::text, 3::integer),
  ('Irgendwas mit Medien'::text, 3::integer),
  ('Partikel-Ökonomie'::text, 3::integer),
  ('Grauzonen'::text, 3::integer),
  ('Sonnenauf- und Untergänge'::text, 3::integer)
  $$,
  'should list only subjects containing more than XX students'
);

PREPARE best_grade_of_student AS
  SELECT 
    S.name, max(E.grade) AS "best grade" 
  FROM 
    exams E 
  JOIN 
    students AS S 
  ON 
    S.student_id = E.student_id 
  GROUP BY 
    S.name;

SELECT set_eq (
  'best_grade_of_student',
  $$VALUES
  ('Jim Knopf'::text, 1::integer),
  ('Erika Mustermann'::text, 5::integer),
  ('Lieschen Müller'::text, 2::integer),
  ('Babs Jensen'::text, 3::integer),
  ('Karl Ranseier'::text, 5::integer),
  ('Peter Schmidt'::text, 2::integer),
  ('Tomte Tummetot'::text, 3::integer),
  ('Klaus Meier'::text, 2::integer)
  $$,
  'should list the best grade of the student'
);

SELECT * FROM finish();
ROLLBACK;
