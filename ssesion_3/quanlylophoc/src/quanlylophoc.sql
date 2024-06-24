SELECT *
FROM c0324h1.students;


create database c0324h1;

use c0324h1;

create table teachers
(
    id     int primary key auto_increment,
    name   varchar(100),
    gender bit(1),
    phone  varchar(11),
    dob    date
);


create table classes
(
    id   int primary key auto_increment,
    name varchar(50)
);

create table account_student
(
    username varchar(100) primary key,
    password varchar(200)
);

create table teachers_teach_classes
(
    id_teacher int,
    id_class   int,
    primary key (id_teacher, id_class),
    foreign key fk_classes_teachers (id_class) references classes (id),
    foreign key fk_classes_teachers2 (id_teacher) references teachers (id)
);

create table students
(
    id       int primary key auto_increment,
    name     varchar(100),
    gender   bit(1),
    phone    varchar(11),
    dob      date,
    id_class int,
    username varchar(100) unique,
    foreign key fk_account_students (username) references account_student (username),
    foreign key fk_classes_students (id_class) references classes (id)
);



select students.name, classes.name, teachers.name
from students
         join classes on students.id_class = classes.id
         join teachers_teach_classes on classes.id = teachers_teach_classes.id_class
         join teachers on teachers_teach_classes.id_class = classes.id;
