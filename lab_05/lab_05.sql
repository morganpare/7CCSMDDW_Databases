select * from student;

select distinct name from assessmentType;

select distinct name from department;

select courseID, name from course;

select
  score as mark,
  day(timestamp) as day,
  month(timestamp) as month
from mark;

select studentID, fname, lname from student
where city = 'London'
;

select studentID, fname, lname from student
order by lname, fname
;

select * from department
where upper(name) like '%SCIENCE%'
order by address
;

select studentID, fname, lname, dateOfBirth from student
where city = 'London'
order by address
;

select * from mark where score between 60 and 69;

select * from assessment where weight < 30 and typeID != 1;

select fname, lname, city from student where city like 'A%';

select fname, lname, city from student
where upper(city) in (
  'LONDON','BOLTON','CAMBRIDGE'
)
;

select distinct city from student
where upper(city) in (
  'LONDON','BOLTON','CAMBRIDGE'
)
;

select count(*) from student;

select count(*) from takesCourse where courseID = 203;

select count(distinct assessmentId) from mark;

select avg(score) from mark;

select max(score) from mark;

select min(score) from mark;

select courseID, count(distinct moduleID) from module group by courseID;

select city, count(*) from student group by city;

select departmentId, count(*) from course
where upper(name) like '%PHD%'
group by departmentId;

select assessmentId, avg(score) from mark
group by assessmentId;

select moduleID from assessment
group by moduleID
having count(*) > 3
;

select year(dateOfBirth) as year, count(*) from student
group by year
order by year asc;

select studentID, count(distinct courseID) from takesCourse
group by studentID
;
