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
 
 select * from student;
 select * from student where Status = true;
 select * from subject where Credit<10;
 
select s.StudentID, s.StudentName, c.ClassName from student s 
join class c on s.ClassID = c.ClassID;

select s.StudentID, s.StudentName , sub.SubName, sub.Credit from student s
join mark m on s.StudentID = m.StudentID
join subject sub on sub.SubID = m.SubID
where sub.SubName = 'CF';