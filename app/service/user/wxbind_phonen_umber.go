package user

import (
	"daigou/app/model"
	"daigou/app/service/user/sessionman"
	"daigou/library/zaplog"

	"github.com/gogf/gf/net/ghttp"
	"github.com/medivhzhan/weapp/v2"
)

type WxBindPhoneNumberReq struct {
	EncryptedData string `json:"encryptedData"`
	Iv            string `json:"iv"`
}

type WxBindPhoneNumberResp struct {
	PhoneNumber string `json:"phone_number"`
	Code        int32  `json:"code"` //错误码(0:表示成功)
	Msg         string `json:"msg"`  //提示信息
}

// 验证code获取token
func WxBindPhoneNumber(req *WxBindPhoneNumberReq, session *ghttp.Session) (resp *WxBindPhoneNumberResp, err error) {
	zaplog.Debugf("req=%+v", req)

	//判断userInfo
	userInfo := sessionman.GetUserInfo(session)
	sessionInfo := sessionman.GetSessionInfo(session)

	weappResp, err := weapp.DecryptMobile(sessionInfo.SessionKey, req.EncryptedData, req.Iv)
	if err != nil {
		zaplog.Errorf("WxBindPhoneNumber err:%s", err)
		return nil, err
	}

	//写入数据库
	err = model.BindPhoneNumber(&model.DbBindPhoneNumberIn{UserID: userInfo.UserID, PhoneNumber: weappResp.PhoneNumber, CountryCode: weappResp.CountryCode})
	if err != nil {
		zaplog.Errorf("WxBindPhoneNumber err:%s", err)
		return nil, err
	}
	//更新session信息
	userInfo.PhoneNumber = weappResp.PhoneNumber
	sessionman.UpdateSession(session, userInfo)
	resp = &WxBindPhoneNumberResp{
		Code:        0,
		Msg:         "绑定手机号成功",
		PhoneNumber: weappResp.PhoneNumber,
	}
	return
}
