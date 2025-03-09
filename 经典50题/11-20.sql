use classic50;
# 11、查询没有学全所有课程的同学的信息
select s.*
from student s
where s_id not in (select s_id from score group by s_id having count(*) = (select count(*) from course));
# 12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息
select s.*
from student s
where s_id != '1' in (select s_id from score where c_id in (select c_id from score where s_id = '1'));
# 13.查询和"01"号的同学学习的课程完全相同的其他同学的信息
# 思路1:先内连接1同学学过的课程，再比较筛选出与他课程数量相同的同学
select s.*
from student s
where s_id != '1'
  and s_id in (select s_id
               from score s1
                        inner join(select c_id from score s2 where s2.s_id = '1') t1 # 内连接1同学学过的课程
                                  on s1.c_id = t1.c_id)
  and s_id in (select s_id from score group by s_id having count(*) = (select count(*) from score where s_id = '1'));
# 思路2：全称量词查询
select s.*
from student s
where s_id != '1'
  and not exists (select s2.*
                  from score s2
                  where s2.s_id = '1'#作用：找出'1'号学生选修了，但当前学生s未选修的课程。
                    and not exists (select s3.* from score s3 where s.s_id = s3.s_id and s2.c_id = s3.c_id));
# not exists： 它是一个条件判断，当子查询没有返回任何行时，主查询的当前行会被保留。中文翻译，全部都不满足我才要
# 14、查询没学过"张三"老师讲授的任一门课程的学生姓名
select s.s_name
from student s
where s_id not in (select s_id
                   from score
                   where c_id in (select c_id
                                  from course,
                                       teacher
                                  where teacher.t_id = course.t_id
                                    and teacher.t_name = '张三'));

select s_name
from student
where s_id not in (select s_id
                   from score sc
                            inner join (select c_id
                                        from course c
                                                 inner join teacher t on c.t_id = t.t_id
                                        where t_name = '张三') t1
                                       on sc.c_id = t1.c_id);

# 15、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
select s.s_id, s_name, avg_score
from student s
         inner join (select s_id, avg(s_score) as avg_score
                     from score
                     where score.s_score < 60
                     group by score.s_id
                     having count(*) > 1) t1 on s.s_id = t1.s_id;

# 16、检索"01"课程分数小于60，按分数降序排列的学生信息
select s.*, sc.s_score
from student s
         inner join (select s_id, s_score from score where c_id = '1' and s_score < 60) sc on sc.s_id = s.s_id
order by sc.s_score desc;
# 17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
# 思路：行转列
select s.s_id,
       s.s_name,
       sum(case sc.c_id when '1' then s_score else 0 end) course1,
       sum(case sc.c_id when '2' then s_score else 0 end) course2,
       sum(case sc.c_id when '3' then s_score else 0 end) course3,
       ifnull(avg(sc.s_score), 0)                         avg_score
from student s
         left join score sc on sc.s_id = s.s_id
group by s.s_id, s.s_name
order by avg_score desc;
# 18、查询各科成绩最高分、最低分和平均分，以如下形式显示：
# 课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
# – 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
select c.c_id   as                                                                                         课程ID,
       c.c_name as                                                                                         课程名称,
       max(s.s_score)                                                                                      最高分,
       min(s.s_score)                                                                                      最低分,
       avg(s.s_score)                                                                                      平均分,
       concat(round(sum(case when s_score >= 60 then 1 else 0 end) / count(*) * 100, 2), '%')              及格率,
       concat(round(sum(case when s_score between 70 and 80 then 1 else 0 end) / count(*) * 100, 2), '%')  中等率,
       concat(round(sum(case when s_score between 80 and 90 then 1 else 0 end) / count(*) * 100, 2), '%')  优良率,
       concat(round(sum(case when s_score between 90 and 100 then 1 else 0 end) / count(*) * 100, 2), '%') 优秀率
from score s
         left join course as c on c.c_id = s.c_id
group by c.c_id, c.c_name;
# 19、按各科成绩进行排序，并显示排名
# 思路：排名就是需要统计分数比自身大的记录数量，各科需要按课程号进行分组
select c_id,
       s2.s_score,
       1 + (select count(*) from score s1 where s1.c_id = s2.c_id and s1.s_score > s2.s_score) srank
# 注意主查询是s2
from score s2
order by c_id, s_score desc;
# 20、查询学生的总成绩并进行排名
with t as (select s_id,
                  sum(s1.s_score) sum_score
           from score s1
           group by s1.s_id)
select s_name, student.s_id, sum_score, 1 + (select count(*) from t t1 where t1.sum_score > t2.sum_score) srank
from t t2,
     student
where t2.s_id = student.s_id
order by srank;


