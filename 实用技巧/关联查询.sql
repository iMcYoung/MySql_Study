use dql;

alter table students
    add class varchar(10);
delete
from students
where name is null;

update students
set class = 1
where sid = 1;

update students
set class = 2
where sid = 2;

update students
set class = 3
where sid = 3;

create table school
(
    class int(10),
    grade varchar(10)
)
insert into school
values (1, 1),
       (2, 2),
       (3, 3);

-- 内连接inner join ... on... ,on 后面加条件。
-- 查询所有同学的姓名，成绩还有年级
select score, name, grade
from students
         inner join school on students.class = school.class
where gender = '男';

select score, name, grade
from students
         inner join school using (class)
where gender = '男';

-- 以一张表为基础，若能匹配则展示出来
select students.score, students.name, school.grade
from school
         left join students on school.class = students.class;

-- 自连接
select *
from students,
     school
where school.class = students.class;
