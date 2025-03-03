-- 多条件查询，给出and(&&),or(||)
-- where 条件1 and 条件2 (同时满足)
-- where 条件1 or 条件2 (满足一个即可)
-- 查询男同学且分数大于99
select  * from students where gender='男' and score>99;
-- 查询男同学或者分数大于99
select  * from students where gender ='男' or score> 99;
-- null——mysql中特殊的判断，is null 或者is not null
-- 查询没有邮箱的同学
select * from  students where email is null;