insert into class(ClassName,StartDate,Status) values 
 ('A1','2008-12-20',1),
 ('A2','2008-12-22',1),
 ('B3',current_date(),0);
 
insert into student(StudentName,Address,Phone,Status,ClassID) values
('Hung','Ha noi','0912113113',1,1),
('Hoa','Hai phong','',1,1),
('Manh','HCM','0123135',0,2);

INSERT INTO subject
VALUES 
 (1, 'CF', 5, 1),
 (2, 'C', 6, 1),
 (3, 'HDJ', 5, 1),
 (4, 'RDBMS', 10, 1);
 
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
 (2, 2, 10, 2),
 (3, 3, 12, 1);
 
 select * from student  where StudentName like 'H%'; 
 select * from class where month(StartDate) = 12; 
 select SubName,Credit from subject where Credit between 3 and 5;

set sql_safe_updates = 0;
update student set ClassID = 2 where StudentName = 'Hung';
set sql_safe_updates = 1;

select stu.StudentName, sub.SubName , m.Mark from student stu
join mark m on m.StudentID = stu.StudentID
join subject sub on sub.SubID = m.SubID
order by m.Mark desc;
-- order by stu.StudentName asc;