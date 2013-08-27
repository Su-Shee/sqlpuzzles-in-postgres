-- pg_prove -U postgres -d sqlpuzzles 01-moarjoins-tables.sql --verbose
-- psql -U postgres -d sqlpuzzles -Xf 01-moarjoins-tables.sql

BEGIN;

SELECT plan(45);

SELECT has_table('students');
SELECT has_pk('students');

SELECT has_column('students', 'student_id');
SELECT has_column('students', 'name');
SELECT has_column('students', 'major');

SELECT col_not_null('students', 'student_id');
SELECT col_not_null('students', 'name');
SELECT col_not_null('students', 'major');

SELECT col_type_is('students', 'student_id', 'integer');
SELECT col_type_is('students', 'name', 'text');
SELECT col_type_is('students', 'major', 'text');

SELECT has_table('subjects');
SELECT has_pk('subjects');

SELECT has_column('subjects', 'subject_id');
SELECT has_column('subjects', 'subject');

SELECT col_not_null('subjects', 'subject_id');
SELECT col_not_null('subjects', 'subject');

SELECT col_type_is('subjects', 'subject_id', 'integer');
SELECT col_type_is('subjects', 'subject', 'text');

SELECT has_table('classes');
SELECT has_pk('classes');

SELECT has_column('classes', 'student_id');
SELECT has_column('classes', 'subject_id');

SELECT col_is_fk('classes', 'student_id');
SELECT col_is_fk('classes', 'subject_id');

SELECT col_not_null('classes', 'student_id');
SELECT col_not_null('classes', 'subject_id');

SELECT col_type_is('classes', 'student_id', 'integer');
SELECT col_type_is('classes', 'subject_id', 'integer');

SELECT has_table('exams');
SELECT has_pk('exams');

SELECT has_column('exams', 'grade');
SELECT has_column('exams', 'exam');
SELECT has_column('exams', 'student_id');
SELECT has_column('exams', 'subject_id');

SELECT col_not_null('exams', 'grade');
SELECT col_not_null('exams', 'exam');
SELECT col_not_null('exams', 'student_id');
SELECT col_not_null('exams', 'subject_id');

SELECT col_is_fk('exams', 'student_id');
SELECT col_is_fk('exams', 'subject_id');

SELECT col_type_is('exams', 'grade', 'integer');
SELECT col_type_is('exams', 'exam', 'date');
SELECT col_type_is('exams', 'student_id', 'integer');
SELECT col_type_is('exams', 'subject_id', 'integer');

SELECT * FROM finish();
ROLLBACK;
