package user

import (
	"daigou/app/model"
	"daigou/library/redis"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type SendSmsCodeReq struct {
	redis.RedisSendSmsCodeIn
}

type SendSmsCodeResp struct {
	*redis.RedisSendSmsCodeOut
}

// 验证code获取token
func SendSmsCode(req *SendSmsCodeReq, session *ghttp.Session) (resp *SendSmsCodeResp, msg string, err error) {
	zaplog.Debugf("req=%+v", req)
	//判断验证码是否正确

	var redisOut *redis.RedisSendSmsCodeOut
	redisOut, msg, err = redis.RedisSendSmsCode(&req.RedisSendSmsCodeIn)
	if err != nil {
		zaplog.Errorf("SendSmsCode err:%s", err)
		return nil, "", err
	}

	return &SendSmsCodeResp{RedisSendSmsCodeOut: redisOut}, msg, nil
}

//判断该手机号是否已经绑定
func IsbindPhoneNumber(PhoneNumber string) (resp *model.IsBindPhoneNumberReq, msg string, err error) {
	resp, msg, err = model.IsbindPhoneNumber(PhoneNumber)
	if err != nil {
		zaplog.Errorf("SendSmsCode err:%s", err)
		return nil, "", err
	}

	return resp, msg, nil
}
