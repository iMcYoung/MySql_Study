create  database if not exists xxbg;
show databases;
use xxbg;

create table a(
 a int
);
-- 删除当前数据库
drop table  if  exists a;
-- 修改表名
alter  table students rename  to student;
alter table  student rename to students;
-- 给学生表加一行classroom，数据类型为varchar(10)
alter table students add classroom varchar(10);
-- 删除classroom列
alter table students drop  classroom;
-- 将students表中的phone改为telephone，数据类型不变
alter table students change phone telephone varchar(25);


