package conf

import (
	"context"
	"daigou/library/zaplog"
	"fmt"
	"time"

	"github.com/go-redis/redis/v8"
	_ "github.com/go-sql-driver/mysql"
	"github.com/gogf/gf/database/gredis"
	"github.com/gogf/gf/os/gtimer"
	"github.com/jinzhu/gorm"
	"github.com/xormplus/core"
	"github.com/xormplus/xorm"
	"github.com/xormplus/xorm/log"
)

var connect DaigouConnect

type DaigouConnect struct {
	GormDB *gorm.DB
	XormDB *xorm.Engine
	Redis  *redis.Client
}

func GetGormDb() *gorm.DB {
	return connect.GormDB
}

func GetRedis() *redis.Client {
	return connect.Redis
}

func GetXormDB() *xorm.Engine {
	return connect.XormDB
}

func InitConnect() (conn *DaigouConnect) {
	connect.initDb()
	connect.initRedis()
	return &connect
}

type DbGormLogger struct {
	*zaplog.Logger
	Stdout bool
}

func (logger *DbGormLogger) Print(v ...interface{}) {
	if v[0] == "sql" {
		logger.Sugar().Infof("file:%s time:[%s] sql:%s arg:%+v,index:%d", v[1], v[2], v[3], v[4], v[5])
	} else {
		logger.Sugar().Info(v...)
	}
	if logger.Stdout {
		fmt.Println(gorm.LogFormatter(v...))
	}
}

type DbXormLogger struct {
	*zaplog.Logger
	Stdout   bool
	LogLevel log.LogLevel
}

func (logger *DbXormLogger) Debug(v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Debug(v...)
}

func (logger *DbXormLogger) Debugf(format string, v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Debugf(format, v...)
}

func (logger *DbXormLogger) Error(v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Error(v...)
}

func (logger *DbXormLogger) Errorf(format string, v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Errorf(format, v...)
}
func (logger *DbXormLogger) Info(v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Info(v...)
}

func (logger *DbXormLogger) Infof(format string, v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Infof(format, v...)
}

func (logger *DbXormLogger) Warn(v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Warn(v...)
}

func (logger *DbXormLogger) Warnf(format string, v ...interface{}) {
	if !logger.Stdout {
		return
	}
	logger.Sugar().Warnf(format, v...)
}

func (logger *DbXormLogger) Level() log.LogLevel {
	return log.LOG_DEBUG
}

func (logger *DbXormLogger) SetLevel(l log.LogLevel) {
}

func (logger *DbXormLogger) ShowSQL(show ...bool) {
}

func (logger *DbXormLogger) IsShowSQL() bool {
	return true
}

func (conn *DaigouConnect) pingXorm() {
	err := conn.XormDB.DB().Ping() //测试是否连接成功
	if err != nil {
		zaplog.Errorf("pingXorm err=%s", err)
		return
	}
}

func (conn *DaigouConnect) pingGorm() {
	err := conn.GormDB.DB().Ping() //测试是否连接成功
	if err != nil {
		zaplog.Errorf("pingGorm err=%s", err)
		return
	}
}

func (conn *DaigouConnect) initDb() {
	//init gorm
	var err error
	retryTimes := 60
	link := Conf.Database["default"].Link
	for i := 0; i < retryTimes; i++ {
		zaplog.Infof("try to connect mysql %s the %d time", link, i)
		conn.GormDB, err = gorm.Open("mysql", link)
		err = conn.GormDB.DB().Ping() //测试是否连接成功
		if err == nil {
			break
		}
		time.Sleep(time.Second)
	}
	if err != nil {
		zaplog.Fatalf("err=%s", err)
		return
	}
	gtimer.AddSingleton(time.Minute, conn.pingGorm)
	conn.GormDB.LogMode(Conf.Database["default"].Debug)
	gormFileLogger := zaplog.NewLogger(&zaplog.Config{
		Logdir:   Conf.Database["default"].Logdir,
		LogName:  fmt.Sprintf("%s%s", "-gorm-", Conf.Database["default"].LogName),
		Loglevel: Conf.Database["default"].Loglevel,
		Debug:    false,
	}, 1)
	conn.GormDB.SetLogger(&DbGormLogger{Logger: gormFileLogger, Stdout: Conf.Database["default"].Debug})

	//取消表名的复数形式，使得表名和结构体名称一致
	conn.GormDB.SingularTable(true)
	sqlDb := conn.GormDB.DB()
	sqlDb.SetConnMaxLifetime(time.Minute * 10)
	sqlDb.SetMaxOpenConns(30)
	sqlDb.SetMaxIdleConns(15)

	//init xormplus
	conn.XormDB, err = xorm.NewEngine(xorm.MYSQL_DRIVER, Conf.Database["default"].Link)
	err = conn.XormDB.Ping() //测试是否连接成功
	if err != nil {
		zaplog.Fatalf("err=%s", err)
		return
	}
	gtimer.AddSingleton(time.Minute, conn.pingXorm)
	conn.XormDB.ShowSQL(true)
	xormFileLogger := zaplog.NewLogger(&zaplog.Config{
		Logdir:   Conf.Database["default"].Logdir,
		LogName:  fmt.Sprintf("%s%s", "-xorm-", Conf.Database["default"].LogName),
		Loglevel: Conf.Database["default"].Loglevel,
		Debug:    Conf.Database["default"].Debug,
	}, 6)
	conn.XormDB.SetLogger(&DbXormLogger{Logger: xormFileLogger, Stdout: Conf.Database["default"].Debug})
	conn.XormDB.SetMapper(core.GonicMapper{})
	conn.XormDB.SetConnMaxLifetime(time.Minute * 10)
	conn.XormDB.SetMaxOpenConns(30)
	conn.XormDB.SetMaxIdleConns(15)

	return
}

func (conn *DaigouConnect) pingRedis() {
	pong, err := conn.Redis.Ping(context.Background()).Result() //测试是否连接成功
	if err != nil {
		zaplog.Errorf("pingRedis pong=%s,err=%s", pong, err)
		return
	}
}

func (conn *DaigouConnect) initRedis() {
	gURL, err := gredis.ConfigFromStr(Conf.Redis["cache"])
	if err != nil {
		zaplog.Panicf("initRedis err:%s", err)
	}
	// url := fmt.Sprintf("redis://%s:%d/%d#%s", gURL.Host, gURL.Port, gURL.Db, gURL.Pass)
	// zaplog.Infof("initRedis url=%s", url)
	// opt, err := redis.ParseURL(url)
	// if err != nil {
	// 	zaplog.Panicf("initRedis err:%s", err)
	// }
	_Addr := fmt.Sprintf("%s:%d", gURL.Host, gURL.Port)
	opt := &redis.Options{
		Addr:     _Addr,
		DB:       gURL.Db,
		Password: gURL.Pass,
	}
	retryTimes := 60
	for i := 0; i < retryTimes; i++ {
		zaplog.Infof("try to connect redis the %d time", i)
		conn.Redis = redis.NewClient(opt)
		_, err = conn.Redis.Ping(context.Background()).Result() //测试是否连接成功
		if err == nil {
			break
		}
		time.Sleep(time.Second)
	}
	if err != nil {
		zaplog.Fatalf("pingRedis err=%s", err)
		return
	}
	gtimer.AddSingleton(time.Minute, conn.pingRedis)
}
