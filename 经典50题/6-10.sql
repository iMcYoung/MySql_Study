# 6.查询"李"姓老师的数量
select count(t_id)
FROM teacher
where t_name like '李%'
group by t_name;

select count(*) as cnt_name_li
from teacher
where t_name like '李%';
#7.学过"张三"老师授课的同学的信息
# 思路1：嵌套查询,先查询老师，再查询---占内存且速度慢
select student.*
from student
where s_id in (select s_id
               from score
               where c_id in (select c_id from course where t_id in (select t_id from teacher where t_name = '张三')));
# 思路2:natural join
select student.*
from student
         natural join score
         natural join course
         natural join teacher
where t_name = '张三';
# 思路3 .inner join
select student.*
from student
         inner join score on student.s_id = score.s_id
         inner join course on score.c_id = course.c_id
         inner join teacher on course.t_id = teacher.t_id
where teacher.t_name = '张三';
# 8、查询没学过"张三"老师授课的同学的信息
select s.*
from student s
where s_id not in (select distinct s_id
                   from score sc
                            inner join (select c_id
                                        from course c
                                                 inner join teacher t on c.t_id = t.t_id
                                        where t_name = '张三') t1
                                       on sc.c_id = t1.c_id);
select s.*
from student s
where s_id not in
      (select s_id
       from score
       where c_id in (select c_id from course where t_id in (select t_id from teacher where t_name = '张三')));
# 9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
# 思路1：嵌套查询，同时满足俩条件
select s.*
from student s
where s_id in (select s_id from score where c_id = '1')
  and s_id in (select s_id from score where c_id = '2');
# 思路2:先合成一个表，再筛选
select s.*
from student s
         inner join (select s_id from score where c_id = '1') c1 on s.s_id = c1.s_id
         inner join(select s_id from score where c_id = '2') c2 on s.s_id = c2.s_id;

select s.*
from student s,
     (select * from score where c_id = '1') s1,
     (select * from score where c_id = ' 2') s2
where s.s_id = s1.s_id
  and s.s_id = s2.s_id

# 10.查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息
#思路1:嵌套查询
select s.*
from student s
where s_id in (select s_id from score where c_id = '1')
  and s_id not in (select s_id from score where c_id = '2')
#思路2: 用except 和natural join except
select s.*
from student s
         natural join score s1
except
select s.*
from student s natural join score s2
where c_id ='2'
