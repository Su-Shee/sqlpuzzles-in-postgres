select stu.name, sub.subject, gr.grade
from students stu
join (
   select student_id, max(grade) as "grade"
   from exams e
   join subjects s
   on e.subject_id = s.subject_id
   group by student_id
) gr
on gr.student_id = stu.student_id
join exams ex
on ex.grade = gr.grade
and ex.student_id = stu.student_id
join subjects sub
on sub.subject_id = ex.subject_id
group by stu.student_id, sub.subject, gr.grade;

SELECT name, subject, grade FROM
(SELECT student_id, subject_id, grade, RANK() OVER (PARTITION BY student_id
    ORDER BY grade)
  FROM exams)
AS grades, students, subjects
WHERE grades.subject_id = subjects.subject_id AND grades.student_id =
students.student_id
AND rank = 1 ORDER BY grade;
