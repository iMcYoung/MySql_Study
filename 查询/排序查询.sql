use dql;
-- 排序查询，模版 select 字段 from 表 order by 排序字段, 排序字段[ASC/DESC][升序/降序]
-- 按照生日查询姓名，降序
select * from students order by birthday desc;
-- 将所有男同学的生日升序排列
select * from students where gender='男' order by birthday;
-- 将所有男同学的生日升序排列，若相同，则按分数降序排列
select  * from  students where gender = '男' order by  birthday,score asc ,score desc;
