-- 聚类查询以列为基础，会脱离数据的独立性，用于单独统计某一列数据的特征
-- 列数据 ，求最大值，最小值，平均值，总和，个数
-- 格式，select 聚合函数(列名) from 表名 列名;
-- 聚合函数(1): 求个数聚合count(列名)
use dql;
select count(email) from students;-- ()可以写*统计整张表的数据
select count(*) from students;
-- 聚合函数(2):求最大值max()
select max(score) from students;
-- 一次类推还要min, avg ,sum
-- 求所有男生的平均分
select avg(score) from students where gender ='男';
