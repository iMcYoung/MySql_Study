create database classic50;
use classic50;
create table student (
	s_id int,
	s_name varchar(8),
	s_birth date,
	s_sex varchar(4)
);
insert into student values
(1,'赵雷','1990-01-01','男'),
(2,'钱电','1990-12-21','男'),
(3,'孙风','1990-05-20','男'),
(4,'李云','1990-08-06','男'),
(5,'周梅','1991-12-01','女'),
(6,'吴兰','1992-03-01','女'),
(7,'郑竹','1989-07-01','女'),
(8,'王菊','1990-01-20','女');
create table course (
	c_id int,
	c_name varchar(8),
	t_id int
);
insert into course values
(1,'语文',2),
(2,'数学',1),
(3,'英语',3);

