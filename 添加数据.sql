-- 新建一个数据库用于保存DML(数据增删改)语句相关内容
create database dml;
use dml;
-- 添加一条数据()；如果添加的直接是数字，则直接写，如果是字符串，则要加''/",日期
insert into students (sid, name, gender, birthday, score, status)
values (1, '张二狗', '男', '1999-11-11', 100.00, 0);
-- 指定列添加多条数据
insert into students (sid, name, gender, birthday, score, phone, status)
values ( 2, "刘铁柱"
       , '男', '1999-10-01', 98.5, 16651070149, 0),
       (3, '李狗蛋', '女', '2001-01-01', 100.00, 16651070150, 0)
-- 全部列添加数据
insert into students
values (4, '666', '男', '2001-01-01', 100.00, 16651070150, 16651070149, 0)