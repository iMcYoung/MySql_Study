use dql;
-- 模糊查询 ：格式，like
-- 模糊查询值：带有特殊标识符号的字符串。
-- 特殊的标识符号：_ ，表示任意一个字符匹配
-- 特殊的标识符号：%，表示任意N个字符匹配


-- 查询姓张的且是三个字的学生数据
select  *  from students where name like '张__';
-- 查询第三个字是狗的学生信息
select * from students where name like '%狗';
-- 查询是yaya邮箱的同学信息
select  * from students where email like '%ya%';
-- 查询手机号码带66的同学信息
select  *from students where phone like '%66%';