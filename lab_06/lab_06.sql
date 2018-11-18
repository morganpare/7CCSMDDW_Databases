-- List modules that belong to computing courses
select distinct m.name
from module m
inner join course c using(courseId)
inner join department d using(departmentId)
where d.departmentId = 1
order by m.name
;

-- List the names of all assessments that have never been marked
select distinct a.name
from assessment a
left outer join mark m using(assessmentId)
-- where m.assessmentId is null
;

-- Display the names of the students that are not taking any course
select distinct s.fname, s.lname
from student s
left outer join takesCourse t using(studentId)
;

-- List the name and description of all assessments of type ’Coursework’
select distinct a.name
from assessment a
inner join assessmentType t
using (typeId)
where t.typeId = 3
;

 -- What is the average mark for all the examinations? Solution 50.5958
select avg(m.score)
from mark m
inner join assessment a
using (assessmentId)
where a.typeId = 6;

-- What is the average mark for assessments of module 4638573? Solution: 34.667
select avg(m.score)
from mark m
inner join assessment a
using (assessmentId)
where a.moduleId = 4638573;

-- Display the names of the departments that deliver some PhD course
select distinct d.name, c.name
from department d
inner join course c
using(departmentId)
where upper(c.name) like '%PHD%'
;

-- Display the id of all departments that give more than one PhD course. (Note there is just one department
-- that meets these criteria)
select d.name, count(distinct c.name)
from department d
inner join course c
using(departmentId)
where upper(c.name) like '%PHD%'
group by d.name
having count(distinct c.name) > 1
;

-- How many students have higher scores than the average score of student 34? (Note there are 378)
--find the average score of student 34
select count(*) from (
  select studentId, avg(score)
  from mark
  group by studentId
  having avg(score) >
  (
    select avg(score)
    from mark
    where studentId = 34
  )
)
;

-- How many students have higher scores than all the scores of student 34? (Note there are 37)
select count(distinct studentId)
from mark
where score >
(
  select avg(score)
  from mark
  where studentId = 34
)
;

-- Display the names of the students that have higher marks than all the marks of student 34
select distinct s.*
from mark m
inner join student s
using(studentId)
where m.score >
(
  select max(score)
  from mark
  where studentId = 34
)
;

-- List the name of all courses in department 52 together with the number of credits that each course has.
-- You must obtain the following output (the order of the rows may be different):
select
  c.name,
  sum(m.credits)
from course c
inner join module m
using(courseId)
where c.departmentId = 52
group by c.name;

-- List the description of all assessments and the maximum mark obtained by the students in this
-- assignment. Note that all assignments should be displayed, even if they have not been marked.
select
  a.description,
  max(m.score) as max_score
from assessment a
left join mark m
using(assessmentId)
group by a.description
;

-- List all the departments together with the names of the courses they offer
select distinct
  d.name as department_name,
  c.name as course_name
from department d
inner join course c
using(departmentId)
order by d.name
;

-- List the names of the students together with their scores
select distinct
  s.fname,
  s.lname,
  m.assessmentId,
  m.score
from student s
inner join mark m
using(studentId)
order by s.fname, s.lname, m.assessmentId, m.score
;

-- List the names of the students together with their scores and the weights of each assessment
select distinct
  s.fname,
  s.lname,
  m.assessmentId,
  m.score,
  a.weight
from student s
inner join mark m
using(studentId)
inner join assessment a
using(assessmentId)
order by s.fname, s.lname, m.assessmentId, m.score
;

-- List the names of the students together with their pondered scores (score*weight/100)
select distinct
  s.fname,
  s.lname,
  m.assessmentId,
  m.score,
  a.weight,
  m.score*a.weight/100 as pondered_score
from student s
inner join mark m
using(studentId)
inner join assessment a
using(assessmentId)
order by s.fname, s.lname, m.assessmentId, m.score
;

-- List the students together with their mark for the modules in which they have been assessed
select distinct
  s.fname,
  s.lname,
  mo.moduleId,
  mo.name as module_name,
  round(sum(m.score*a.weight/100)) as pondered_score
from student s
inner join mark m
using(studentId)
inner join assessment a
using(assessmentId)
inner join module mo
using(moduleId)
group by s.fname, s.lname, mo.moduleId, mo.name
order by s.fname, s.lname, mo.moduleId, mo.name
;

-- List the ID, the name and the number of students on each course
select
  c.courseId,
  c.name as course_name,
  count(distinct t.studentId)
from course c
inner join takesCourse t
using(courseId)
group by
  c.courseId,
  c.name
;

-- Calculate the number of students in the most taken course
select max(count_students) from (
  select
    c.courseId,  round(sum(m.score*a.weight/100)) as pondered_score
    c.name as course_name,
    count(distinct t.studentId) as count_students
  from course c
  inner join takesCourse t
  using(courseId)
  group by
    c.courseId,
    c.name
) t
;

-- List the name and the number of students of the most taken course
select s.* from student s
inner join takesCourse t
using(studentId)
where courseId in
(
  select courseId from course c
  inner join takesCourse t using(courseId)
  group by courseId
  having count(distinct studentId) = (
    select max(count_students) from (
      select
        c.courseId,
        c.name as course_name,
        count(distinct t.studentId) as count_students
      from course c
      inner join takesCourse t
      using(courseId)
      group by
        c.courseId,
        c.name
    ) t
  )
)
;

-- Calculate the final marks for student 164 in all modules on course 36.
select mo.name,
  round(sum(ma.score*a.weight/100)) as total_marks
from module mo
inner join assessment a
using(moduleId)
inner join mark ma
using(assessmentId)
where ma.studentId = 164
  and mo.courseId = 36
group by mo.name
;

-- There is an spelling error on the city of some students it has been defined as ’Lodon’ but it should be
-- ’London’. Use a SQL query to correct this mistake
update student set
  city = 'London'
  where city = 'Lodon'
;

-- The city of all departments have not been defined. But you can know the city from the address (that
-- is the address indicates the name of the city where the campus is). Use SQL queries to correct this
-- mistake.
update department set
  city = replace(address, ' Campus', '')
;

-- A query using the HAVING clause has an equivalent formulation without a HAVING clause. For example,
-- reformulate the following query without using a HAVING clause:
-- SELECT studentID,count(assessmentID)
-- FROM mark
-- GROUP BY studentID
-- HAVING count(assessmentID)=5;
select studentID, count_assessment_id
from (
  SELECT studentID,count(assessmentID) as count_assessment_id
  FROM mark
  GROUP BY studentID
) t
where t.count_assessment_id = 5
;
