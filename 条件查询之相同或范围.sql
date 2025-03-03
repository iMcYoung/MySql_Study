-- select 字段别名 from 表名列表 where 条件列表
-- 条件查询：内容相同的过滤方式（列名=目标值）
-- 查询姓名是张二狗的学生信息
use dql;
select *
from students
where name = '张二狗';
-- 查询所有性别为男的学生信息
select *
from students
where gender = '男';
delete
from students
where name = '666';
-- 条件查询：范围过滤方式(列名 运算符 目标值) 运算符：> < >= <= <> !=
-- 范围可以判断的一半是数值或日期，一般不查字符串
select *
from students
where score >= 90;
-- mysql中越近的日期越大，越远的的日期越小
select *from students where birthday>'1999-01-01';