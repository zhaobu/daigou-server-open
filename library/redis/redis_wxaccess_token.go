package redis

import (
	"context"
	"daigou/library/conf"
	"daigou/library/zaplog"
	"time"

	"github.com/medivhzhan/weapp/v2"
)

//获取微信接口调用凭证
func GetAccessToken() (token string, err error) {
	//优先从redis中获取
	conn := cache.Conn(context.Background())
	defer conn.Close()
	token, err = conn.Get(context.Background(), Cache_Str_WxAccess_token).Result()
	if err == nil && token != "" {
		return
	}

	res1, err1 := weapp.GetAccessToken(conf.Conf.Weapp.AppID, conf.Conf.Weapp.Secret)
	if err1 != nil {
		// 处理一般错误信息
		zaplog.Errorf("GetAccessToken err:%s", err1)
		return "", err1
	}
	if err = res1.GetResponseError(); err != nil {
		// 处理微信返回错误信息
		zaplog.Errorf("GetAccessToken res1:%+v", res1)
		return "", err
	}
	//缓存到redis中
	_expiresInS := res1.ExpiresIn - uint(1800) //内部定义为是1个半小时之内的值有效。
	//缓存到redis中
	res2, err2 := conn.Set(context.Background(), Cache_Str_WxAccess_token, res1.AccessToken, time.Duration(_expiresInS)*time.Second).Result()
	if err2 != nil {
		// 处理微信返回错误信息
		zaplog.Errorf("GetAccessToken res2:%+v", res2)
		return "", err2
	}
	return res1.AccessToken, nil
}

//获取微信公众号接口调用凭证
func GetGzhAccessToken() (token string, err error) {
	//优先从redis中获取
	conn := cache.Conn(context.Background())
	defer conn.Close()
	token, err = conn.Get(context.Background(), Cache_Str_WxGzhAccess_token).Result()
	if err == nil && token != "" {
		return
	}

	res1, err1 := weapp.GetAccessToken(conf.Conf.Weapp.GongZhongHao.AppID, conf.Conf.Weapp.GongZhongHao.Secret)
	if err1 != nil {
		// 处理一般错误信息
		zaplog.Errorf("GetAccessToken err:%s", err1)
		return "", err1
	}
	if err = res1.GetResponseError(); err != nil {
		// 处理微信返回错误信息
		zaplog.Errorf("GetAccessToken res1:%+v", res1)
		return "", err
	}

	//缓存到redis中
	_expiresInS := res1.ExpiresIn - uint(1800) //内部定义为是1个半小时之内的值有效。
	res2, err2 := conn.Set(context.Background(), Cache_Str_WxGzhAccess_token, res1.AccessToken, time.Duration(_expiresInS)*time.Second).Result()
	if err2 != nil {
		// 处理微信返回错误信息
		zaplog.Errorf("GetAccessToken res2:%+v", res2)
		return "", err2
	}
	return res1.AccessToken, nil
}
