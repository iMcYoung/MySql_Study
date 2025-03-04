-- 纵表转横表
-- 每个男同学的分数纵向展示
select students.name
from students
group by name
use dql;
select name,
       min(case gender
               when '男' then score
               else 0
           end) '男',
       min(case gender
               when '女' then score
               else 0
           end) '女'
from students
group by name;
select name, group_concat(score), group_concat(gender)
from students
group by name;



create view vstu as
select name,
       min(case gender
               when '男' then score
               else 0
           end) '男',
       min(case gender
               when '女' then score
               else 0
           end) '女'
from students
group by name;;
select *
from vstu;

create table score
(
    name   varchar(10),
    course varchar(10),
    score  int(100)
)
insert into score
values ('张三', '数学', 98),
       ('李四', '数学', 77),
       ('王五', '数学', 88),
       ('张三', '语文', 66),
       ('李四', '语文', 55),
       ('王五', '语文', 44),
       ('张三', '英语', 66),
       ('李四', '英语', 55),
       ('王五', '英语', 44)
select*
from score;

select name,
       sum(case
           course
               when '语文' then score
               else 0 end) '语文',
       sum(case
           course
               when '数学' then score
               else 0 end) '数学',
       sum(case
           course
               when '英语' then score
               else 0 end) '英语'
from score
group by name;
create view vscore as select name,
       sum(case
           course
               when '语文' then score
               else 0 end) '语文',
       sum(case
           course
               when '数学' then score
               else 0 end) '数学',
       sum(case
           course
               when '英语' then score
               else 0 end) '英语'
from score
group by name;
select * from vscore;
select name ,'语文' course, 语文 score from vscore
union all
select name ,'数学' course, 数学 score from vscore
union all
select name ,'英语' course, 英语 score from vscore