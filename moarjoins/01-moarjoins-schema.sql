-- psql -U postgres -d sqlpuzzles < 01-moarjoins-schema.sql

-- scoring/ranking, (self) joins
CREATE TABLE students (
  student_id INTEGER NOT NULL UNIQUE,
  name TEXT NOT NULL,
  major TEXT NOT NULL,
  PRIMARY KEY (student_id)
);

CREATE TABLE subjects (
  subject_id INTEGER NOT NULL UNIQUE,
  subject TEXT NOT NULL,
  PRIMARY KEY (subject_id)
);

CREATE TABLE classes (
  subject_id INTEGER NOT NULL REFERENCES subjects(subject_id),
  student_id INTEGER NOT NULL REFERENCES students(student_id),
  PRIMARY KEY (subject_id, student_id)
);

CREATE TABLE exams (
  exam DATE NOT NULL,
  grade INTEGER NOT NULL,
  subject_id INTEGER NOT NULL REFERENCES subjects(subject_id),
  student_id INTEGER NOT NULL REFERENCES students(student_id),
  PRIMARY KEY (exam, student_id, subject_id)
);
