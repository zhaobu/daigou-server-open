# 代购微信小程序

## 目录结构

| 目录/文件名称 | 说明           | 描述                                                                  |
| ------------- | -------------- | --------------------------------------------------------------------- |
| app           | 业务逻辑层     | 所有的业务逻辑存放目录。                                              |
| \- api        | 业务接口       | 接收/解析用户输入参数的入口/接口层。                                  |
| \- model      | 数据模型       | 数据管理层，仅用于操作管理数据，如数据库操作。                        |
| \- service    | 逻辑封装       | 业务逻辑封装层，实现特定的业务需求，可供不同的包调用。                |
| boot          | 初始化包       | 用于项目初始化参数设置，往往作为 `main.go` 中第一个被 `import` 的包。 |
| bin           | 项目运行目录   | 包括docker运行环境，配置文件等等。                                    |
| \- docker     | docker配置目录 | 包括所有的docker运行环境                                              |
| config        | 配置文件目录   | config1.toml为配置文件目录                                             |
| document      | 项目文档       | Document项目文档，如: 设计文档、帮助文档等等。                        |
| \- sql        | 数据库相关     | 数据库生成脚本, 数据库说明文档等。                                    |
| library       | 公共库包       | 公共的功能封装包，往往不包含业务需求实现。                            |
| swagger       | 接口文档       | 使用swagger生成api接口文档。                                          |
| router        | 路由注册       | 用于路由统一的注册管理。                                              |
| go.mod        | 依赖管理       | 使用 `Go Module` 包管理的依赖描述文件。                               |
| main.go       | 入口文件       | 程序入口文件。                                                        |

## 开发文档

项目采用[GoFrame框架](https://github.com/gogf/gf), 有关框架的介绍文档请访问[Goframe官方文档](https://goframe.org/index)

## 安装说明

1. 以管理员身份打开PowerShell: 然后输入 `set-executionpolicy remotesigned ` , 选择 `Y` 

2. 去[golang下载地址](https://studygolang.com/dl)下载安装好后,配置好GOPATH,GOBIN环境变量,并且把$GOPAH/bin目录加入到PATH环境变量中

3. 在PowerShell执行 `go env -w GOPROXY=https://goproxy.cn,direct`命令,设置好goproxy代理

4. 执行env-init.ps1初始化环境

5. 安装docker运行环境([docker下载地址](https://www.docker.com/get-started)), 并且设置好docker镜像加速,vscode安装docker插件,然后在bin/docker目录执行 `docker-compose -up -d` 启动mysql和redis相器

   可以用如下镜像加速地址:

   ```json
   {
     "registry-mirrors": [
     	"https://docker.mirrors.ustc.edu.cn/",
     	"https://hub-mirror.c.163.com",
     	"https://registry.docker-cn.com",
       "https://dockerhub.azk8s.cn",
       "https://reg-mirror.qiniu.com",
       "https://registry.docker-cn.com"
     ]
   }
   ```

   

6. 如果在document/sql目录下有数据库脚本,可以执行`db-gen-models.ps1`根据document/sql目录下的sql初始化好数据库表

## 使用go-swagger生成api文档

1. 安装好本地golang环境,配置好GOPATH,GOBIN环境变量,并且把$GOPAH/bin目录加入到PATH环境变量中
2. 给app/api下的每个Controller的接口按照swagger的规范写好注释,[注释规范参考](https://github.com/swaggo/swag/blob/master/README_zh-CN.md),每次添加或者接口参数有更新时,注意要及时更新接口注释,因为swagger生成接口文档给客户端查看是根据注释来的
3. 每次更新注释后都要执行`swag init --output ./swagger --generatedTime=true --markdownFiles=true`命令会在swagger目录下重新生成swagger配置文件
4. swagger的默认访问地址是[http://127.0.0.1:8199/swagger](http://127.0.0.1:8199/swagger),账号密码由config1.toml里面的swagger配置

## 使用gf-cli工具

1. 执行gf_gen_models.ps1脚本,执行后会生成数据库操作的相关代码到app/model目录下

## 使用sql-migrate同步数据库
1. env-init.ps1里有安装sql-migrate的步骤
2. [教程地址](https://github.com/rubenv/sql-migrate)

## 其他

1. 阅读[Goframe官方文档](https://goframe.org/toolchain/cli#), 工具链相关章节, gf.exe工具下账地址为<https://github.com/gogf/gf-cli>
2. 使用`git config --global --add core.autocrlf false`可以设置git提交时line endings将不做转换操作。文本文件保持原来的样子
3. 常用的git命令可以参考[git同步远程分支](https://www.jianshu.com/p/3be4029ce854)
