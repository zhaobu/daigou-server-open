// 定时任务
package cron

import (
	"daigou/library/conf"
	"daigou/library/redis"
	"daigou/library/zaplog"
	"time"

	"github.com/gogf/gf/os/gcron"
	"github.com/gogf/gf/os/glog"
	"github.com/gogf/gf/os/gtimer"
)

func initCronLog() {
	gcron.SetLogPath(conf.Conf.Cron.Logdir)
	gcron.SetLogLevel(glog.LevelStr(conf.Conf.Cron.Loglevel).GetLevel())
}

//初始化定时任务
func InitCron() {
	initCronLog()
	cronDeleteSmsCode()
	cronUpdateShopCode()
	zaplog.Infof("all cron jobs initial success")
}

//定时删除验证码信息
func cronDeleteSmsCode() {
	interval := time.Duration(conf.Conf.Smscode.ValidTime) * time.Second
	gtimer.AddSingleton(interval, func() {
		redis.RedisDeleteSmsCode()
	})
	zaplog.Infof("cronDeleteSmsCode success interval=%s", interval)
}

//定时删除验证码信息
func cronUpdateShopCode() {
	interval := time.Second * 2
	gtimer.AddSingleton(interval, func() {
		redis.UpdateShopCode()
	})
	zaplog.Infof("cronUpdateShopCode success interval=%s", interval)
}
