# 数据库表规范

1. 数据库字符集采用支持表情符号的utf8mb4,排序规则采用大小写敏感的utf8mb4_bin,在新建表和数据库时需要注意,避免因为字符集的问题出现乱码,关于字符集的问题,可以参考[mysql字符集](https://www.cnblogs.com/qtiger/p/13039875.html)
2. 在docker-compose和config1.toml文件中已经将mysql的server和client端字符集和排序规则已经统一
3. 数据库的表名称,字段名称都采用snake蛇形命名法,也就是用下划线将单词连接起来
4. 所有分支下的数据库都以master分支下的为准,每个人负责不同功能,在功能完成后,需要代码连同sql语句一起同步到master分支.
5. 修改或者新增表后,如果功能未开发完成,可以先不把sql同步到master分支,避免表结构修改,造成其他人老的代码操作新的数据库出问题
6. 每张表我都添加了四个字段,对应的事gorm.Model,这四个字段一般不用自己维护,只做查询用,其中deleted_at字段可以应付需要软删除的场景,如果确实需要删除一条记录,使用`db.Unscoped().Delete(&order)`[](https://gorm.io/zh_CN/docs/delete.html)
