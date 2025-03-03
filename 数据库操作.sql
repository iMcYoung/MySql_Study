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