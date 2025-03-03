-- 创建数据库用于保存DQL相关操作
create database dql;
use dql;
-- 查询表中的全部字段信息
select *
from students;

-- 思考1 先执行select还是from？
-- 答：先执行from再执行select
-- 思考2 执行完查询操作后，得到的是什么？
-- 答：得到的是一张表，只不过不存在于本地，是一张伪表。
-- 查询表的部分字段
select name, gender
from students;
-- 到了公司不能上来就select *，会占用服务器资源。
-- distinct可以除去重复的数据，例如查询gender只剩下男女
select distinct gender from students;

-- 起别名查询,查询多表时非常有效
select s.name , s.gender from students  as  s ;
select s.name as '姓名', s.gender as '性别' from students  as  s ;
