package redis

import (
	"context"
	"daigou/app/model/entity"
	"daigou/library/zaplog"
	"errors"

	jsoniter "github.com/json-iterator/go"
)

//获取系统配置表
func GetSystemConfig() (out []*entity.SystemConfig, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()
	v1, err := conn.Get(context.Background(), Cache_Str_System_Config).Result()
	if err != nil || v1 == "" {
		//redis查询不到,就从db读取
		zaplog.Errorf("GetSystemConfig err=%s,", err)
		out = make([]*entity.SystemConfig, 0, 5)
		err = dbGorm.Table("system_config").Scan(&out).Error
		if err != nil {
			zaplog.Errorf("GetSystemConfig err=%s", err)
			return
		}
		//写入到redis
		marshalToRedis(Cache_Str_System_Config, out, 0)
		return
	}
	err = jsoniter.Unmarshal([]byte(v1), &out)
	return
}

func GetSystemConfigValue(_arg string) (out string, err error) {
	res, err := GetSystemConfig()
	if err != nil {
		zaplog.Errorf("GetSystemConfigValue err=%s", err)
		return "", err
	}
	for _, v := range res {
		if v.ClassName == _arg {
			return v.ClassValue, nil
		}
	}
	return "", errors.New("not find")
}

type redisGoodsCategory struct {
	CategoryID   int32  `json:"category_id"`
	CategoryName string `json:"category_name"`
}

//获取商品分类信息表
func GetGoodsCategory() (res map[int32]string, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()
	v1, err := conn.Get(context.Background(), Cache_Str_Goods_Category).Result()
	if err != nil || v1 == "" {
		//redis查询不到,就从db读取
		zaplog.Errorf("GetGoodsCategory err=%s,", err)
		info := []*entity.GoodsCategory{}
		err = dbGorm.Find(&info).Error
		if err != nil {
			zaplog.Errorf("GetGoodsCategory err=%s", err)
			return nil, err
		}

		//写入到redis
		res = make(map[int32]string, len(info))
		for _, v := range info {
			res[v.CategoryID] = v.CategoryName
		}
		marshalToRedis(Cache_Str_Goods_Category, res, 0)
		return
	}

	err = jsoniter.Unmarshal([]byte(v1), &res)
	return
}
