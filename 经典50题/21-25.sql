# 21.查询不同老师所教不同课程平均分从高到低显示
select t.t_name,
       c.c_id,
       c.c_name,
       avg(sc.s_score) avg_score
from teacher t,
     course c,
     score sc
where t.t_id = c.t_id
  and c.c_id = sc.c_id
group by t.t_name, c.c_id, c.c_name
order by avg_score desc;
# 22、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩
select s.*,
       t1.c_id,
       ifnull(t1.s_score, 0) as s_score
from student s,
     score t1
where t1.s_id = s.s_id
  and (1 + (select count(*)
            from score t2
            where t1.s_score < t2.s_score
              and t2.c_id = t1.c_id))
    in (2, 3);
# 23、统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
select sc.c_id,
       c.c_name,
       sum(case when sc.s_score between 85 and 100 then 1 else 0 end) as                               '[100-85]',
       concat(round(sum(case when sc.s_score >= 85 then 1 else 0 end) / count(*), 2), '%')             百分比,
       sum(case when sc.s_score between 70 and 85 then 1 else 0 end)  as                               '[85-70]',
       concat(round(sum(case when sc.s_score between 70 and 85 then 1 else 0 end) / count(*), 2), '%') 百分比,
       sum(case when sc.s_score between 60 and 70 then 1 else 0 end)  as                               '[70-60]',
       concat(round(sum(case when sc.s_score between 60 and 70 then 1 else 0 end) / count(*), 2), '%') 百分比,
       sum(case when sc.s_score between 0 and 60 then 1 else 0 end)   as                               '[0-60]',
       concat(round(sum(case when sc.s_score between 0 and 60 then 1 else 0 end) / count(*), 2), '%')  百分比
from score sc
         left join course c
                   on sc.c_id = c.c_id
group by sc.c_id, c.c_name;
# 24、查询学生平均成绩及其名次
with st as (select student.s_id, avg(score.s_score) avg_score
            from student
                     inner join score on student.s_id = score.s_id
            group by s_id)
select 1 + (select count(*) from st t2 where t2.avg_score > t1.avg_score) srank, t1.s_id, avg_score
from st t1,
     student
where t1.s_id = student.s_id
order by srank;
# 25、查询各科成绩前三名的记录
select s1.*
from score s1
where (select count(*) from score sc where sc.s_score > s1.s_score and sc.c_id = s1.c_id) < 3
order by s1.c_id, s1.s_score desc;





