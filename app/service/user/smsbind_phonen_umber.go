package user

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/redis"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
)

type SmsBindPhoneNumberReq struct {
	redis.RedisGetSmsCodeIn
}

type SmsBindPhoneNumberResp struct {
	Code int32 `json:"code"` //错误码(0:表示成功 1:过期 2:无效)
}

func SmsBindPhoneNumber(req *SmsBindPhoneNumberReq, session *ghttp.Session) (resp *SmsBindPhoneNumberResp, msg string, err error) {
	zaplog.Debugf("req=%+v", req)

	//判断验证码是否正确
	out1, msg1, err1 := redis.RedisGetSmsCode(&req.RedisGetSmsCodeIn)
	if err1 != nil {
		zaplog.Errorf("SmsBindPhoneNumber err:%s", err1)
		return nil, "", err1
	}

	if out1.Code != redis.RedisGetSmsCodeOut1_Success {
		zaplog.Errorf("SmsBindPhoneNumber msg:%s", msg1)
		resp = &SmsBindPhoneNumberResp{
			Code: int32(out1.Code),
		}
		return resp, msg1, nil
	}
	//判断userInfo
	userInfo := sessionman.GetUserInfo(session)

	//写入数据库
	err = model.BindPhoneNumber(&model.DbBindPhoneNumberIn{UserID: userInfo.UserID, PhoneNumber: req.PhoneNumber})
	if err != nil {
		zaplog.Errorf("SmsBindPhoneNumber err:%s", err)
		return nil, "", err
	}
	//更新session信息
	userInfo.PhoneNumber = req.PhoneNumber
	sessionman.UpdateSession(session, userInfo)
	resp = &SmsBindPhoneNumberResp{
		Code: 0,
	}
	msg = "绑定手机号成功"
	return
}
