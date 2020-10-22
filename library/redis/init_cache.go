package redis

import (
	"context"
	"daigou/library/conf"
	"daigou/library/zaplog"
	"time"

	"github.com/go-redis/redis/v8"
	"github.com/jinzhu/gorm"
	jsoniter "github.com/json-iterator/go"
	"github.com/xormplus/xorm"
)

var (
	dbGorm   *gorm.DB
	dbXorm   *xorm.Engine
	cache    *redis.Client
	isEnable = false //是否初始化成功
)

//server启动时需要从数据库读取到redis中的数据
func InitRedis() {
	dbXorm = conf.GetXormDB()
	dbGorm = conf.GetGormDb()
	cache = conf.GetRedis()
	if dbXorm == nil || dbGorm == nil || cache == nil {
		zaplog.Fatalf("InitRedis err")
	}
	isEnable = true
}

func IsEnable() bool {
	return isEnable
}

//序列化到redis
func marshalToRedis(key string, v interface{}, expiration time.Duration) {
	conn := cache.Conn(context.Background())
	defer conn.Close()
	//序列化
	info, err := jsoniter.MarshalToString(v)
	if err != nil {
		zaplog.Errorf("marshalToRedis err=%s", err)
		return
	}

	//存储到redis中
	res, err := conn.Set(context.Background(), key, info, expiration).Result()
	if err != nil {
		// 处理微信返回错误信息
		zaplog.Errorf("marshalToRedis err=%s,res2:%+v,", err, res)
		return
	}
}
