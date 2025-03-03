# 1.数据库的增删改查

```mysql
-- 查询所有数据
show databases;
-- 创建数据库
create database xxbg;
-- 创建数据库，如果不存在则创建，存在则创建
create database if not exists xxbg;
-- Mac特别提醒,出现乱码要指定编码
create database if not exists xxbg charset utf8;
-- 删除数据库
DROP database xxbg;
-- 如果存在则删除
drop database if exists xxbg;
-- 查看你当前正在使用的数据库
select database();
-- 使用指定的数据库
use xxbg;
-- 视频链接：https://www.bilibili.com/video/BV1FD4y1W77x?spm_id_from=333.788.videopod.sections&vd_source=1edc3e20c7a80f1d50c41c8fce9c98c7
```

# 2.数据表的查询操作

```mysql
-- 查询当前数据库下所有表的名称
show tables;
-- 查询表结构
desc 表名称;
-- Field ->表中字段信息  type ->该字段能够存储什么类型的数据()
-- null ->能不能是空值 
```

# 3. 操作表

## 3.1 创建表

```mysql
create table 表名 (
	字段名1 数据类型
  字段名2 数据类型
)
```

- mysql 数据类型
- ![image-20250226232646561](/Users/jky/Library/CloudStorage/OneDrive-Personal/LCY/Python/Mysql/image-20250226232646561.png)

- Mysql 常用数据选择

  - 1，数值型 —— tinyint (年龄)，int(整数数字)，double(小数数字)

  - 2，日期型—— date (年月日：生日) ，datetime(年月日分秒：提交订单时间/付款时间)

  - 3， 字符串型 —— char (定长字符串)：制定最多存储的字符个数，无论存多少个字符，都占用固定的空间

       varchar(变长字符串)：指定最多存储的字符个数，占多少个字符，就占多大的空间+1 ，实际空间大小。



## 3.2 例子



<img src="/Users/jky/Library/Application Support/typora-user-images/image-20250226231536164.png" alt="image-20250226231536164" style="zoom:33%;" />

```mysql
create table students(
    sid int, -- 编号作为数据类型，int作为数据类型直接写即可
    name varchar (10),-- 姓名作为字符串类型，varchar/char作为数据类型后面要加一个().里面写最多存储的字符数。
    gender char (1),-- 只有一个字(定长字符串)
    birthday date , -- 生日选择日期类型，只有年月日选择date类型
    score double(5,2), -- 分数选择为数据类型，double作为数据类型，不建议只写一个double，建议在double的后面加上一个(m,n),m:数字的最大位数(整+小) n:数字的最大位数(小)
    email varchar(64),-- 邮件选择字符串类型，选择varchar变长字符串，(邮件的地址长度不一样)
    phone varchar(20),
    status tinyint  -- 状态选择数字类型，由于状态不是特别多，选择tinyint
    );
-- 视频链接：https://www.bilibili.com/video/BV1UY4y1f7jX?spm_id_from=333.788.videopod.sections&vd_source=1edc3e20c7a80f1d50c41c8fce9c98c7
```

```mysql
-- 删除当前数据库
drop table  if  exists a;
```

``` mysql
-- 修改表名
alter  table students rename  to student;
alter table  student rename to students;
-- 给学生表加一列 classroom，数据类型为varchar(10)
alter table students add classroom varchar(10);
-- 删除classroom列
alter table students drop  classroom;
-- 删除classroom列
alter table students drop  classroom;
```

## 3.2 DML语句

```mysql
-- 1.给指定列添加数据
insert into 表名(列名1,列名2,列名3,...) values(值1,值2,值3,...);
-- 全部列添加数据
insert into students
values (4, '666', '男', '2001-01-01', 100.00, 16651070150, 16651070149, 0);
-- 替换数据
-- 将'张二狗'的email改成143
update students set email='1439849190@qq.com', phone='12345678901' where name = '张二狗';
-- 删除某一行数据
delete from students where name = '张二狗';
```

## 3.3 条件查询

### 3.31 基础查询

```mysql
-- 思考1 先执行select还是from？
-- 答：先执行from再执行select
-- 思考2 执行完查询操作后，得到的是什么？
-- 答：得到的是一张表，只不过不存在于本地，是一张伪表。
```

```mysql
-- 查询表中的全部字段信息
select *
from students;

-- 查询表的部分字段
select name, gender
from students;
-- 到了公司不能上来就select *，会占用服务器资源。
-- distinct可以除去重复的数据，例如查询gender只剩下男女
select distinct gender from students;

-- 起别名查询
select s.name , s.gender from students  as  s ;
select s.name as '姓名', s.gender as '性别' from students  as  s ;-- as可以不写

-- 查询所有性别为男的学生信息
select *
from students
where gender = '男';
delete
from students
where name = '666';
-- 条件查询：范围过滤方式(列名 运算符 目标值) 运算符：> < >= <= <> !=
-- 范围可以判断的一半是数值或日期，一般不查字符串
select *
from students
where score >= 90;
-- mysql中越近的日期越大，越远的的日期越小
select *from students where birthday>'1999-01-01';
```

### 3.3.1 SQL语法查询

```mysql
-- sql语法条件查询：判断数值在范围之间 ，格式：列名，between 值1 and 值2，值1min,值2max
-- 查询所有分数处于99-100分之间的学生
select * from students where score between 99 and 100;

-- sql语法条件：in(...),判断数值在(...)中的某一个值，格式：列名 in (值1，...)
-- 查询所有分数是0或100的学生
select * from students where score  in (0,100);
```

### 3.3.2 模糊查询

```mysql
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
```

### 3.3.3 多条件连接查询与非空判断

- 多条件查询

```mysql
-- 多条件查询，给出and(&&),or(||)
-- where 条件1 and 条件2 (同时满足)
-- where 条件1 or 条件2 (满足一个即可)
-- 查询男同学且分数大于99
select  * from students where gender='男' and score>99;
-- 查询男同学或者分数大于99
select  * from students where gender ='男' or score> 99;
```

- 非空查询

```mysql
-- null——mysql中特殊的判断，is null 或者is not null
-- 查询没有邮箱的同学
select * from  students where email is null;
```

### 3.3.4 排序查询

```mysql
-- 排序查询，模版 select 字段 from 表 order by 排序字段, 排序字段[ASC/DESC]
select * from students order by birthday desc;
-- 将所有男同学的生日升序排列
select * from students where gender='男' order by birthday;
-- 将所有男同学的生日升序排列，若相同，则按分数降序排列
select  * from  students where gender = '男' order by  birthday,score asc ,score desc;
```

### 3.3.5聚合查询
```

```
