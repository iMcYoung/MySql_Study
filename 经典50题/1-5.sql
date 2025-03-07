# 1、查询"01"课程比"02"课程成绩高的学生的信息及课程分数
use classic50;
select s.*, sc1.s_score 语文, sc2.s_score 数学
from student s
         inner join (select * from score where c_id = 1) sc1 on s.s_id = sc1.s_id
         inner join (select * from score where c_id = 2) sc2 on s.s_id = sc2.s_id
where sc1.s_score > sc2.s_score;
# 2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数
SELECT s.*, sc1.s_score AS 语文, sc2.s_score AS 数学
FROM student s
         INNER JOIN score sc1 ON s.s_id = sc1.s_id AND sc1.c_id = 1
         INNER JOIN score sc2 ON s.s_id = sc2.s_id AND sc2.c_id = 2
WHERE sc1.s_score < sc2.s_score;
# 3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
# 解法1:先把student和score做连接，再求平均成绩
select s.s_id, s.s_name, avg(s_score) as 平均成绩
from student s
         inner join score
                    on score.s_id = s.s_id
group by s.s_id, s.s_name
having avg(s_score) >= 60;
#注意，有了group by之后，select 属性只能来自分组属性
# 解法2:先在score表中按照s.s_id进行分组聚合 计算平均值，在连接student;
select s.s_id, s.s_name, avg
from student s
         inner join (select score.s_id, avg(s_score) avg from score group by s_id) t1 on s.s_id = t1.s_id
where avg >= 60;

# 4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩(包括有成绩的和无成绩的)
# 思路1:先求有成绩的，在union无成绩的
select s.s_id, s.s_name, avg(score.s_score) as avg
from student s,
     score
where s.s_id = score.s_id
group by s.s_id, s.s_name
having avg(score.s_score) < 60
union
select s_id, s_name, 0
from student
where s_id not in (select score.s_id from score);
# 没有这样的学生数据，则必须采用外连接，不能采用左连接或者右连接
select s.s_id, s.s_name, (case when avg_score is null then 0 else avg_score end) as avg_score
from student s
         left join (select s_id,
                           avg(s_score) as
                               avg_score
                    from score
                    group by s_id) t1 on s.s_id = t1.s_id
where avg_score <= 60
   or avg_score is null;
# 5.查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
# 思路：1.先分组计算课程数量和总成绩，再外连接，再用ifnull来将列中存在的null值换成0，
select s.s_id,
       s.s_name,
       ifnull(count_c, 0) as 选课总数,ifnull(sum_s,0) as 总成绩
from student s
         left join (select s_id, count(c_id) count_c, sum(s_score) sum_s from score group by s_id) t1
                   on s.s_id = t1.s_id








