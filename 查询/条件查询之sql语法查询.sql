-- sql语法条件查询：判断数值在范围之间 ，格式：列名，between 值1 and 值2，值1min,值2max
-- 查询所有分数处于99-100分之间的学生
use dql;
select *
from students
where score between 99 and 100;
-- 查询所有日期在1999年出生的学生；
select *
from students
where birthday between '1999-01-01' and '1999-12-31';
-- sql语法条件：in(...),判断数值在(...)中的某一个值，格式：列名 in (值1，...)
-- 查询所有分数是0或100的学生
select * from students where score  in (0,100);
