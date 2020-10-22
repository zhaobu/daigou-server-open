package redis

import (
	"context"
	"daigou/library/conf"
	"daigou/library/utils"
	"daigou/library/zaplog"
	"fmt"
	"time"

	"github.com/gogf/gf/util/gconv"
	"github.com/gogf/gf/util/grand"
	jsoniter "github.com/json-iterator/go"
)

type sendSmsCode struct {
	Code     string    `json:"code"`           //验证码
	SendTime time.Time `json:"last_send_time"` //上次发送的时间
}

type RedisSendSmsCodeOut1 int32

const (
	RedisSendSmsCodeOut1_Success    RedisSendSmsCodeOut1 = iota //发送成功
	RedisSendSmsCodeOut1_Frequently                             //过于频繁
)

type RedisSendSmsCodeIn struct {
	PhoneNumber string `json:"phone_number" v:"phone_number@required|phone#手机号不能为空|手机号有误"` //需要发送验证码的手机号
}

type RedisSendSmsCodeOut struct {
	Code      RedisSendSmsCodeOut1 `json:"code"`       //错误码(0:表示成功 1:发送过于频繁)
	RetryTime int32                `json:"retry_time"` //重新发送时间(单位秒)
	ValidTime int32                `json:"valid_time"` //有效时间(单位秒)
}

//发送验证码
func RedisSendSmsCode(_args *RedisSendSmsCodeIn) (out *RedisSendSmsCodeOut, msg string, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()
	//从redis读取
	var (
		v1      string
		res     *sendSmsCode
		smsConf = conf.Conf.Smscode
	)

	v1, err = conn.HGet(context.Background(), Cache_Hash_Sms_Code, _args.PhoneNumber).Result()

	if v1 != "" { //发送过验证码
		err = jsoniter.Unmarshal([]byte(v1), &res)
		if err != nil {
			zaplog.Errorf("RedisSendSmsCode err=%s", err)
			return nil, "", err
		}
		//判断是否过于频繁
		intervalTime := time.Now().Sub(res.SendTime).Seconds()
		if int32(intervalTime) < smsConf.Frequency {
			out = &RedisSendSmsCodeOut{
				ValidTime: int32(smsConf.ValidTime),
				Code:      RedisSendSmsCodeOut1_Frequently,
				RetryTime: int32(smsConf.Frequency - int32(intervalTime)),
			}
			zaplog.Debugf("RedisSendSmsCode _arg:%+v,out:%+v", _args, out)
			return out, "验证码获取过于频繁", nil
		}
	}

	//重新发送
	code := grand.Digits(int(smsConf.Width))
	err = utils.SendSms(_args.PhoneNumber, code, smsConf.SignName)
	if err != nil {
		zaplog.Errorf("RedisSendSmsCode err:%s", err)
		return nil, "", err
	}
	//序列化
	info, err := jsoniter.MarshalToString(&sendSmsCode{Code: code, SendTime: time.Now()})
	if err != nil {
		zaplog.Errorf("RedisSendSmsCode err=%s", err)
		return nil, "", err
	}
	//写入到redis
	err = conn.HSet(context.Background(), Cache_Hash_Sms_Code, _args.PhoneNumber, info).Err()
	if err != nil {
		zaplog.Errorf("RedisSendSmsCode err=%s", err)
		return nil, "", err
	}

	out = &RedisSendSmsCodeOut{
		ValidTime: int32(smsConf.ValidTime),
		Code:      RedisSendSmsCodeOut1_Success,
		RetryTime: int32(smsConf.Frequency),
	}
	msg = fmt.Sprintf("验证码发送成功,有效期为%d分钟", smsConf.ValidTime/60)
	zaplog.Infof("RedisSendSmsCode success, PhoneNumber:%s,Code:%s", _args.PhoneNumber, code)
	return
}

type RedisGetSmsCodeOut1 int32

const (
	RedisGetSmsCodeOut1_Success RedisGetSmsCodeOut1 = iota //验证码验证通过
	RedisGetSmsCodeOut1_Expired                            //过期
	RedisGetSmsCodeOut1_Invalid                            //无效
)

type RedisGetSmsCodeOut struct {
	Code RedisGetSmsCodeOut1 `json:"code"` //错误码(0:表示成功 1:过期 2:无效)
}

type RedisGetSmsCodeIn struct {
	Code        string `json:"code" v:"code@required#验证码不能为空"`                               //验证码
	PhoneNumber string `json:"phone_number" v:"phone_number@required|phone#绑定手机号不能为空|手机号有误"` //需要绑定的手机号
}

//获取验证码
func RedisGetSmsCode(_args *RedisGetSmsCodeIn) (out *RedisGetSmsCodeOut, msg string, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()
	//从redis读取
	var (
		v1      string
		res     *sendSmsCode
		smsConf = conf.Conf.Smscode
	)

	v1, err = conn.HGet(context.Background(), Cache_Hash_Sms_Code, _args.PhoneNumber).Result()
	if err != nil || v1 == "" {
		zaplog.Errorf("RedisGetSmsCode err:%s", err)
		return
	}

	err = jsoniter.Unmarshal([]byte(v1), &res)
	if err != nil {
		zaplog.Errorf("RedisGetSmsCode err=%s", err)
		return nil, "", err
	}
	out = &RedisGetSmsCodeOut{Code: RedisGetSmsCodeOut1_Success}
	//判断是否相等
	if res.Code != _args.Code {
		out.Code = RedisGetSmsCodeOut1_Invalid
		zaplog.Debugf("RedisGetSmsCode RedisGetSmsCodeOut1_Invalid _arg:%+v,out:%+v", _args, out)
		return nil, "验证码无效", err
	}
	//验证是否过期
	intervalTime := time.Now().Sub(res.SendTime).Seconds()
	if int32(intervalTime) > smsConf.ValidTime { //大于有效期
		out.Code = RedisGetSmsCodeOut1_Expired
		zaplog.Debugf("RedisGetSmsCode RedisGetSmsCodeOut1_Expired _arg:%+v,out:%+v", _args, out)
		return nil, "验证码过期", err
	}

	zaplog.Infof("RedisGetSmsCode success, PhoneNumber:%s,Code:%s", _args.PhoneNumber, _args.Code)
	return
}

//删除所欲过期的手机验证码信息
func RedisDeleteSmsCode() (err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()

	//写入到redis
	var (
		cursor uint64
		keys   []string
	)

	for {
		keys, cursor, err = conn.HScan(context.Background(), Cache_Hash_Sms_Code, cursor, "*", 100).Result()
		if len(keys) == 0 {
			return
		}
		if err != nil {
			zaplog.Errorf("RedisDeleteSmsCode err=%s", err)
			return
		}
		var field string
		//处理拿到的结果
		for k, v := range keys {
			//反序列化
			if k&1 == 0 { //偶数时为field
				field = v
			} else {
				var info *sendSmsCode
				err = jsoniter.Unmarshal(gconv.Bytes(v), &info)
				if err != nil {
					zaplog.Errorf("RedisDeleteSmsCode err=%s", err)
					return
				}
				intervalTime := time.Now().Sub(info.SendTime).Seconds()
				if int32(intervalTime) > conf.Conf.Smscode.ValidTime { //大于有效期

					err = conn.HDel(context.Background(), Cache_Hash_Sms_Code, field).Err()
					if err != nil {
						return
					}
					zaplog.Debugf("RedisDeleteSmsCode del field:%s", field)
				}
			}
		}
		if cursor == 0 {
			return
		}
	}
}
