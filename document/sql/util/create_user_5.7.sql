-- mysql 5.7创建用户
-- https://blog.csdn.net/adu198888/article/details/54092857

-- 新建可以远程登录用户
CREATE USER "daigou"@"%" IDENTIFIED BY "daigou123";

--授权用户拥有数据库的所有权限：(grant 权限 on 数据库.* to 用户名@登录主机 identified by “密码”)
grant all privileges on daigou.* to "daigou"@"%" identified by "daigou123";
flush privileges;

--删除账户及权限：
drop user daigou@"%";