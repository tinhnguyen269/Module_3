use quanlysinhvien;
select Address, count(StudentID) from student
group by Address;

select s.studentID, s.studentName , AVG(Mark) from student s
join mark m on m.StudentID = s.StudentID
group by s.studentID, s.studentName;

select s.studentID, s.studentName , AVG(Mark) from student s
join mark m on m.StudentID = s.StudentID
group by s.studentID, s.studentName
having avg(Mark) > 10;

select s.studentID, s.studentName , AVG(Mark) from student s
join mark m on m.StudentID = s.StudentID
group by s.studentID, s.studentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);

select SubID, SubName, max(Credit) as max from subject
group by SubName,SubID
having max(Credit) = (select max(Credit) from subject);

select sub.SubID, sub.SubName, max(Mark) from subject sub 
join mark m on m.SubID = sub.SubID
group by Sub.SubName,sub.SubID
having max(Mark) = (select max(Mark) from mark);  

select  s.*, avg(Mark) as Diem_TB from student s
join mark m on m.StudentID = s.StudentID
group by m.StudentID
-- having avg(Mark) = (select avg(Mark) from mark)
order by Diem_TB desc;