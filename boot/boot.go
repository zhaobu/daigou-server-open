package boot

import (
	"daigou/app/authcasbin"
	"daigou/app/model"
	"daigou/library/conf"
	"daigou/library/cron"
	"daigou/library/redis"
	"daigou/library/utils"
	"daigou/library/zaplog"
	"daigou/router"
	"flag"
	"fmt"
	"os"

	_ "daigou/swagger"

	"github.com/gogf/gf/frame/g"
	"github.com/gogf/gf/os/gsession"
	"github.com/gogf/swagger"
)

var (
	confPath string //配置文件路径
	debug    bool
)

// 用于应用初始化。
func init() {
	flag.StringVar(&confPath, "confPath", "config/config1.toml", "default config path.")
	flag.BoolVar(&debug, "debug", true, "server debug. or use DEBUG env variable, value: true/false etc.")
	flag.Parse()

	//初始化配置文件
	if err := conf.InitConfig(confPath); err != nil {
		fmt.Printf("读取配置文件出错,err=%s", err)
	}
	//如果是debug模式,每次启动前删除日志
	if conf.Conf.Logger.Debug {
		err := os.RemoveAll(conf.Conf.Env.Logdir)
		err = os.MkdirAll(conf.Conf.Database["default"].Logdir, os.ModePerm)
		if err != nil {
			zaplog.Errorf("os.RemoveAll err=%s", err)
		}
	}
	//初始化日志
	zaplog.InitLog(conf.Conf.Logger)
	zaplog.Infof("config1.toml解析成功:%s", utils.Dump(conf.Conf))

	//初始化httpserver
	s := g.Server()
	s.SetConfigWithMap(conf.GfConf.GetMap("server"))
	s.SetLogPath(conf.Conf.Server.LogPath)
	if conf.Conf.Env.Debug {
		s.Plugin(&swagger.Swagger{})
	}
	//初始化session存储方式
	s.SetSessionStorage(gsession.NewStorageRedis(g.Redis("cache")))

	//初始化路由
	if err := router.InitRouter(); err != nil {
		fmt.Printf("路由配置出错,err=%s", err)
	}

	//初始化Connect
	conf.InitConnect()

	//初始化mysql
	model.InitModel()

	//初始化redis
	redis.InitRedis()

	//初始化定时任务
	cron.InitCron()

	authcasbin.InitCasbin()
	zaplog.Infof("boot init success")
}
